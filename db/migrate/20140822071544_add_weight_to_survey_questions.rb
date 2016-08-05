class AddWeightToSurveyQuestions < ActiveRecord::Migration
  def change
    add_column :survey_questions, :weight, :integer, default: 1
  end
end
