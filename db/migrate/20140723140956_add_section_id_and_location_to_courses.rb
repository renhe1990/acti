class AddSectionIdAndLocationToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :location, :string
    add_column :courses, :section_id, :integer
    add_index :courses, :section_id
  end
end
