class CreateLuckyDrawResults < ActiveRecord::Migration
  def change
    create_table :lucky_draw_results do |t|
      t.references :user, index: true
      t.references :lucky_draw, index: true
      t.references :lucky_draw_item, index: true

      t.timestamps
    end
  end
end
