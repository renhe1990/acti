class RenameSectionIdToCampaignIdInSchedules < ActiveRecord::Migration
  def change
    rename_column :schedules, :section_id, :campaign_id
  end
end
