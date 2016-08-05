class AddTemplateToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :template, :string
  end
end
