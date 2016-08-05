class AddStartsAtAndEndsAtToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :starts_at, :date
    add_column :campaigns, :ends_at, :date
  end
end
