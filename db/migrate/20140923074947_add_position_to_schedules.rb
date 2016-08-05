class AddPositionToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :position, :integer
  end
end
