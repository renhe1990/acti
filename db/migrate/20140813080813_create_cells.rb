class CreateCells < ActiveRecord::Migration
  def change
    create_table :cells do |t|
      t.string :icon
      t.string :title
      t.text :content
      t.string :url, default: nil
      t.boolean :editable, default: true
      t.boolean :active, default: false, index: true
      t.integer :position, default: 0, index: true

      t.timestamps
    end
  end
end
