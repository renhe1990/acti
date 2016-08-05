class AddsStartsAtTimeAndEndAtTimeToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :starts_at_time, :time
    add_column :courses, :ends_at_time, :time
  end
end
