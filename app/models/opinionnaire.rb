class Opinionnaire < Survey::Survey
  AVAILABLE_QUESTION_TYPES = %w(RatingQuestion)

  include Admin::Surveyable

  validates :lecturer_weight, :student_weight, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :reviews, as: :context, dependent: :destroy
  has_many :answers, through: :reviews

  has_many :opinionnaire_reviewees, dependent: :destroy
  accepts_nested_attributes_for :opinionnaire_reviewees
  has_many :reviewees, through: :opinionnaire_reviewees

  validate :total_weight_of_questions_must_be_one_hundred

  def ready_to_submit_for_user?(user)
    (reviewee_ids - reviews.where(reviewer: user).map(&:reviewable_id).uniq).blank?
  end

  def weighted_average_rating_for_user(user)
    return 0 if attempts.count == 0

    questions.inject(0.0) do |result, question|
      result += weighted_average_rating_for_user_and_question(user, question)
    end.round(2)
  end

  def weighted_average_rating_for_user_and_question(user, question)
    return 0 if attempts.count == 0

    ((unified_teacher_weight * average_for_user_and_question_by_teacher(user, question) + unified_student_weight * average_for_user_and_question_by_student(user, question)) * (question.weight/total_weight.to_f)).round(2)
  end

  def unified_teacher_weight
    lecturer_weight.to_f/(lecturer_weight + student_weight)
  end

  def unified_student_weight
    student_weight.to_f/(lecturer_weight + student_weight)
  end

  def average_for_user_and_question_by_teacher(user, question)
    answers = reviews.where("reviews.attempt_id IS NOT NULL").where(reviewable: user).includes(:answers, user: :role).joins(:user, :answers).where("survey_answers.question_id = ?", question.id).select{|review| review.user.teacher?}.flat_map(&:answers)
    answers.empty? ? 0 : answers.sum(&:rating)/answers.count
  end

  def average_for_user_and_question_by_student(user, question)
    answers = reviews.where("reviews.attempt_id IS NOT NULL").where(reviewable: user).includes(:answers, user: :role).joins(:user, :answers).where("survey_answers.question_id = ?", question.id).select{|review| review.user.student?}.flat_map(&:answers)
    answers.empty? ? 0 : answers.sum(&:rating)/answers.count
  end

  def total_weight
    questions.sum(:weight)
  end

  def lecturers
    attempts.includes(participant: :role).map(&:participant).compact.select{ |user| user.teacher? }
  end

  def students
    attempts.includes(participant: :role).map(&:participant).compact.select{ |user| user.student? }
  end

  def update_reviews_and_answers(user, attempt_id)
    reviews.where(reviewer: user).each do |review|
      review.update attempt_id: attempt_id
      review.answers.update_all attempt_id: attempt_id
    end
  end

  def self.question_type_options
    AVAILABLE_QUESTION_TYPES.inject(Hash.new) do |hash, question_type|
      hash[I18n.t("activerecord.models.#{question_type.underscore}")] = question_type.underscore
      hash
    end
  end

  def self.policy_class
    ApplicationPolicy
  end

  def will_score?
    false
  end

  def mandatory?
    true
  end

  def total_weight_of_questions
    # can not use sum(:weight) here which will use sql directly.
    self.questions.inject(0) do |sum, question| sum += question.weight end
  end

  def create_worksheets(book)
    sheet = book.create_worksheet

    sheet.row(0).push '学员'
    sheet.row(0).push '标题'
    questions.each do |question|
      sheet.row(0).push question.title
    end
    sheet.row(0).push '总分'

    reviewees.each_with_index do |reviewee, index|
      row = index + 1
      sheet.row(row).push reviewee.name
      sheet.row(row).push "#{index+1}号"

      questions.each do |question|
        sheet.row(row).push weighted_average_rating_for_user_and_question(reviewee, question)
      end

      sheet.row(row).push weighted_average_rating_for_user(reviewee)
    end
  end

  private
  def total_weight_of_questions_must_be_one_hundred
    self.errors.add(:base, "所有问题的权重之和必须为100") if self.total_weight_of_questions != 100
  end
end
