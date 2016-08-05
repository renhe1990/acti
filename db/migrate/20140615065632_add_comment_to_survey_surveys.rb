class AddCommentToSurveySurveys < ActiveRecord::Migration
  def change
    add_column :survey_surveys, :comment, :text
  end
end
