class CreateLuckyDrawItems < ActiveRecord::Migration
  def change
    create_table :lucky_draw_items do |t|
      t.references :lucky_draw
      t.string :title
      t.text :description
      t.integer :quantity

      t.timestamps
    end
  end
end
