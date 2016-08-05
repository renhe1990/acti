class AddPositionToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :position, :integer
  end
end
