class AddCategoryToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :category, :integer, default: 0
  end
end
