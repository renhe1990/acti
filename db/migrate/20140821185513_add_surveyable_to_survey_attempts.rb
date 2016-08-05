class AddSurveyableToSurveyAttempts < ActiveRecord::Migration
  def change
    add_column :survey_attempts, :surveyable_type, :string
    add_column :survey_attempts, :surveyable_id, :integer
    add_index :survey_attempts, [:surveyable_type, :surveyable_id]
  end
end
