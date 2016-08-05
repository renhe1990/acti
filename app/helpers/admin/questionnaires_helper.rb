module Admin::QuestionnairesHelper
  def survey_answers_in_xls(answers)
    return '/' if answers.blank?

    results = []

    answers.each do |answer|
      results << (answer.option.try(:text) || answer.text || answer.rating)
    end

    results.join(", ")
  end
end
