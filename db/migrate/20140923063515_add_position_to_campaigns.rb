class AddPositionToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :position, :integer
  end
end
