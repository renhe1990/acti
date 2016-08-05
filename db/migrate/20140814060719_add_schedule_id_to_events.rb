class AddScheduleIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :schedule_id, :integer
    add_index :events, :schedule_id
  end
end
