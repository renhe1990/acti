class AddsCourseIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :course_id, :integer
    add_index :events, :course_id
  end
end
