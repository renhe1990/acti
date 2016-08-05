class AddCourseIdToSurveySurveys < ActiveRecord::Migration
  def change
    add_column :survey_surveys, :course_id, :integer
  end
end
