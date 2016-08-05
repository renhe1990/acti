class CreateCourseLecturers < ActiveRecord::Migration
  def change
    create_table :course_lecturers do |t|
      t.references :course
      t.references :lecturer
      t.integer :position

      t.timestamps
    end
  end
end
