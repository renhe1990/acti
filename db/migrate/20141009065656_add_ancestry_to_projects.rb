class AddAncestryToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :ancestry, :string, index: true
  end
end
