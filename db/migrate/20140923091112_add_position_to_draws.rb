class AddPositionToDraws < ActiveRecord::Migration
  def change
    add_column :draws, :position, :integer
  end
end
