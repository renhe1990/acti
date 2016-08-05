class RenameLuckyDrawItemsToDrawItems < ActiveRecord::Migration
  def change
    remove_reference :lucky_draw_items, :lucky_draw
    rename_table :lucky_draw_items, :draw_items

    add_reference :draw_items, :draw
  end
end
