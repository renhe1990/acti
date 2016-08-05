class AddLessonIdToSurveys < ActiveRecord::Migration
  def change
    add_column :survey_surveys, :lesson_id, :integer
    add_index :survey_surveys, :lesson_id
  end
end
