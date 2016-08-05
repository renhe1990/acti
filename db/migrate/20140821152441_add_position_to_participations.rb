class AddPositionToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :position, :integer, default: 0, index: true
  end
end
