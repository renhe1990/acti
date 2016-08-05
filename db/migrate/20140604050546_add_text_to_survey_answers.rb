class AddTextToSurveyAnswers < ActiveRecord::Migration
  def change
    add_column :survey_answers, :text, :text
  end
end
