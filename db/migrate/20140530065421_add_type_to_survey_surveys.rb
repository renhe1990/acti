class AddTypeToSurveySurveys < ActiveRecord::Migration
  def change
    add_column :survey_surveys, :type, :string
    add_index :survey_surveys, :type
  end
end
