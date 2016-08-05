class AddProjectIdToCellsAndBanners < ActiveRecord::Migration
  def change
    add_column :cells, :project_id, :integer, index: true
    add_column :banners, :project_id, :integer, index: true
  end
end
