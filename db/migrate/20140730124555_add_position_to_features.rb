class AddPositionToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :position, :integer, default: 0
    add_index :features, :position
  end
end
