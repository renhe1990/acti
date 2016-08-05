class ChangeStartsAtAndEndsAtToDateInCourses < ActiveRecord::Migration
  def self.up
    change_column :courses, :starts_at, :date
    change_column :courses, :ends_at, :date
  end

  def self.down
    change_column :courses, :starts_at, :datetime
    change_column :courses, :ends_at, :datetime
  end
end
