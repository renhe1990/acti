class AddPositionToSurveySurveys < ActiveRecord::Migration
  def change
    add_column :survey_surveys, :position, :integer
  end
end
