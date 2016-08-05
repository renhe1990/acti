class TrueOrFalseQuestion < Survey::Question
  def label_of_correct_options
    options.select(&:correct).map do |option|
      (options.index(option) + 65).chr
    end.join(", ")
  end

  def accuracy
    return 0.0 if answers.count == 0

    answers.where(option_id: correct_options.ids).count.to_f/answers.count
  end

  def correct_answers_count
    answers.where(option_id: correct_options.ids).count
  end

  def wrong_answers_count
    survey.attempts.count - correct_answers_count
  end

  def selected_options_in_hash
    answers.pluck(:option_id, :attempt_id).inject(Hash.new { |hash, key| hash[key] = []; }) do |h, e|
      h[e.first] << e.last
      h
    end
  end

  def grouped_options
    answers.group_by(&:option_id)
  end
end
