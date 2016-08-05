class AddsDisplayScoreToSurveySurveys < ActiveRecord::Migration
  def change
    add_column :survey_surveys, :display_score, :boolean, default: false
  end
end
