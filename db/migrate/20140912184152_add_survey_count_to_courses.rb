class AddSurveyCountToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :survey_count, :integer, default: 0
  end
end
