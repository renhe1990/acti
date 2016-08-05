class AddNameAndLocationToSections < ActiveRecord::Migration
  def change
    add_column :sections, :name, :string
    add_column :sections, :location, :string
  end
end
