class AddPositionToSurveyQuestions < ActiveRecord::Migration
  def change
    add_column :survey_questions, :position, :integer
  end
end
