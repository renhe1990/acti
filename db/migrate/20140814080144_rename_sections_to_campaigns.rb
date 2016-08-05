class RenameSectionsToCampaigns < ActiveRecord::Migration
  def change
    rename_table :sections, :campaigns
  end
end
