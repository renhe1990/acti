class AddLimitToContentInCells < ActiveRecord::Migration
  def change
    change_column :cells, :content, :text, limit: 4294967295
  end
end
