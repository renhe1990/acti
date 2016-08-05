class RenameSectionIdToCampaignIdInCourses < ActiveRecord::Migration
  def change
    rename_column :courses, :section_id, :campaign_id
  end
end
