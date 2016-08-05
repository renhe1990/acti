module Weixin::AttemptsHelper
  def number_to_char(number)
    (number + 65).chr
  end

  def option_title(index)
    "#{number_to_char(index)}."
  end

  def question_bar_chart(question)
    total = question.survey.attempts.count
    correct = question.correct_answers_count
    wrong = question.wrong_answers_count

    content_tag :div do
      concat question_bar_chart_option('答对人数', total == 0 ? 0 : correct*100/total, correct, class: 'correct')
      concat question_bar_chart_option('答错人数', total == 0 ? 0 : wrong*100/total, wrong, class: 'wrong')
    end
  end

  def question_bar_chart_option(label, progress, result, options = {})
    content_tag :div, class: "bar-chart #{options[:class]} row" do
      concat content_tag :div, label, class: 'col-sm-1 col-xs-3 bar-label'
      concat(content_tag(:div, class: 'col-sm-10 col-xs-7') do content_tag(:div, nil, class: 'bar', style: "width: #{progress}%") end)
      concat(content_tag(:div, class: 'col-sm-1 col-xs-2 bar-result') do content_tag(:span, result) + "人" end)
    end
  end
end
