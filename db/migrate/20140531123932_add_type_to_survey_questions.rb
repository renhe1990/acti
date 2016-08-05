class AddTypeToSurveyQuestions < ActiveRecord::Migration
  def change
    add_column :survey_questions, :type, :string
    add_index :survey_questions, :type
  end
end
