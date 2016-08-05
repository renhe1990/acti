class AddSerialIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :serial_id, :integer, index: true
  end
end
