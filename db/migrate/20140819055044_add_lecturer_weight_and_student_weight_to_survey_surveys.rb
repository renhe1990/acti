class AddLecturerWeightAndStudentWeightToSurveySurveys < ActiveRecord::Migration
  def change
    add_column :survey_surveys, :lecturer_weight, :integer, default: 1
    add_column :survey_surveys, :student_weight, :integer, default: 1
  end
end
