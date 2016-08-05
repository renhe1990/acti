class AddTitleDescriptionToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :title, :string
    add_column :menus, :description, :text
  end
end
