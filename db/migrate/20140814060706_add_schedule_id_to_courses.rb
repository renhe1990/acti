class AddScheduleIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :schedule_id, :integer
    add_index :courses, :schedule_id
  end
end
