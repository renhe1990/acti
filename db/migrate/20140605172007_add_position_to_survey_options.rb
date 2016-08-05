class AddPositionToSurveyOptions < ActiveRecord::Migration
  def change
    add_column :survey_options, :position, :integer
  end
end
