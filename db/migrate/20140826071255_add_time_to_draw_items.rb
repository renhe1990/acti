class AddTimeToDrawItems < ActiveRecord::Migration
  def change
    add_column :draw_items, :time, :datetime
  end
end
