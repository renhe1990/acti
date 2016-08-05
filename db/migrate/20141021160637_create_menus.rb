class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.string :url
      t.boolean :private, default: false
      t.string :ancestry, index: true
      t.timestamps
    end
  end
end
