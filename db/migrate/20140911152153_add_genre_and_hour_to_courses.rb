class AddGenreAndHourToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :genre, :string
    add_column :courses, :hour, :string
  end
end
