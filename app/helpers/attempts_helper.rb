module AttemptsHelper
  def format_bar_chart_data(question)
    if question.is_a?(RatingQuestion)
      1.upto(question.maximum).inject(Hash.new(0)) do |hash, index|
        hash[index.to_s] = question.answers.where(rating: index).count
        hash
      end
    else
      question.options.each_with_index.inject(Hash.new(0)) do |hash, (option, index)|
        hash[(65 + index).chr] = option.answers.count
        hash
      end
    end
  end

  def customized_bar_chart(survey, question, options = {})
    data = format_bar_chart_data(question)

    if survey.will_score?
      title = content_tag(:span) do
        "正确答案: #{ question.options.correct.to_a.map(&:to_char).join(' ') }"
      end + content_tag(:span, style: 'margin-left: 20px') do
        "正答率: #{ (100 * question.accuracy).try(:round, 2) }%"
      end
    end

    bar_chart data, library: {
                      plotOptions: {
                        bar: {
                          dataLabels: {
                            enabled: true }
                        }
                      },
                      title: {
                        text: title,
                        align: 'left',
                        useHTML: true
                      },
                      tooltip: { enabled: false },
                      chart: { backgroundColor: '#e9f2fc' },
                      xAxis: { gridLineWidth: 0 },
                      yAxis: {
                        gridLineWidth: 0,
                        labels: { enabled: false }
                      }
                    }
  end

  def answers_in_xls(answers)
    return '/' if answers.blank?

    results = []

    answers.each do |answer|
      results << (answer.option.try(:text) || answer.text || answer.rating)
    end

    results.join(", ")
  end
end
