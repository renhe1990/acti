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
    puts 'xls导出前时间：' << Time.at(Time.new.to_i).to_s
    sheet = book.create_worksheet

    sheet.row(0).push self.name
    sheet.row(1).push self.description

    sheet.row(3).push '学员'
    questions.each do |question|
      sheet.row(3).push question.title
    end
#    attempts.each_with_index do |attempt, index|
#      sheet.row(4 + index).push attempt.participant.try(:name)
#      questions.each do |question|
#        sheet.row(4 + index).push survey_answers_in_xls question.answers.where(attempt: attempt)
#      end
#    end
    sql = "SELECT CONCAT_WS('#%',IFNULL(u. NAME,''),(SELECT GROUP_CONCAT(CONCAT(IFNULL((SELECT o.text FROM survey_options o WHERE o.id = ans.option_id),''),IFNULL(ans.text,''),IFNULL(ans.rating,'')) ORDER BY ans.question_id SEPARATOR '#%') FROM survey_answers ans WHERE ans.attempt_id = a.id)) FROM survey_attempts a LEFT JOIN users u ON a.participant_id = u.id WHERE a.survey_id = #{self.id}"
    results = ActiveRecord::Base.connection().execute(sql)
    results.each_with_index do |result,index|
      result[0].split('#%').each do |celldata|
        sheet.row(4 + index).push celldata
      end
    end
    puts 'xls导出后时间：' << Time.at(Time.new.to_i).to_s
  end

#  def to_csv
#    output = CSV.generate do |csv|
#      csv << Array.new(1){self.name}
#      csv << Array.new(1){self.description}
#      csv << Array.new
#      titles = Array.new
#      titles << '学员'
#      questions.each do |question|
#        titles << question.title
#      end
#      csv << titles
#      sql = "SELECT CONCAT_WS('#%',IFNULL(u. NAME,''),(SELECT GROUP_CONCAT(CONCAT(IFNULL((SELECT o.text FROM survey_options o WHERE o.id = ans.option_id),''),IFNULL(ans.text,''),IFNULL(ans.rating,'')) ORDER BY ans.question_id SEPARATOR '#%') FROM survey_answers ans WHERE ans.attempt_id = a.id)) FROM survey_attempts a LEFT JOIN users u ON a.participant_id = u.id WHERE a.survey_id = #{self.id}"
#      results = ActiveRecord::Base.connection().execute(sql)
#      results.each do |result|
#        csv << result[0].split('#%')
#      end
#    end
#    "\xEF\xBB\xBF" << output.force_encoding("UTF-8")
#  end

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
