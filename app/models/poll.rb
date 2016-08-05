class Poll < Survey::Survey
  AVAILABLE_QUESTION_TYPES = %w(SingleChoiceQuestion MultipleChoiceQuestion TextQuestion RatingQuestion)

  include Admin::Surveyable

  def self.question_type_options
    AVAILABLE_QUESTION_TYPES.inject(Hash.new) do |hash, question_type|
      hash[I18n.t("activerecord.models.#{question_type.underscore}")] = question_type.underscore
      hash
    end
  end

  def copy
    poll = Poll.new(self.attributes.except("id"))
    poll.questions = self.questions.map do |question|
      options = question.options.map { |option| Survey::Option.new(option.attributes.except("id")) }
      question = Survey::Question.new(question.attributes.except("id"))
      question.options = options
      question
    end
    poll
  end

  def will_score?
    false
  end

  def mandatory?
    false
  end

  def has_answers?
    false
  end

  def create_worksheets(book)
    sheet = book.create_worksheet

    sheet.row(0).push self.name
    sheet.row(1).push self.description

    sheet.row(3).push '学员'
    questions.each do |question|
      sheet.row(3).push question.title
    end

    attempts.each_with_index do |attempt, index|
      sheet.row(4 + index).push attempt.participant.try(:name)
      questions.each do |question|
        sheet.row(4 + index).push survey_answers_in_xls question.answers.where(attempt: attempt)
      end
    end
  end

  def survey_answers_in_xls(answers)
    return '/' if answers.blank?

    results = []

    answers.each do |answer|
      results << (answer.option.try(:text) || answer.text || answer.rating)
    end

    results.join(", ")
  end

  def self.search(keyword = '', options = {})
    scope = where("LOWER(name) LIKE ?", "%#{keyword.downcase}%")
    scope.page(options[:page])
  end
end
