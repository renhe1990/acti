class AddUserIdToSurveySurveys < ActiveRecord::Migration
  def change
    add_column :survey_surveys, :user_id, :integer
    add_index :survey_surveys, :user_id
  end
end
