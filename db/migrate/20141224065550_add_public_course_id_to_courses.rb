class AddPublicCourseIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :public_course_id, :integer, index: true
  end
end
