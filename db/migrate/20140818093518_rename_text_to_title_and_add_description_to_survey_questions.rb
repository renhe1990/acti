class RenameTextToTitleAndAddDescriptionToSurveyQuestions < ActiveRecord::Migration
  def change
    rename_column :survey_questions, :text, :title
    add_column :survey_questions, :description, :text
  end
end
