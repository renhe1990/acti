class AddPositionToDrawItems < ActiveRecord::Migration
  def change
    add_column :draw_items, :position, :integer, default: 1
  end
end
