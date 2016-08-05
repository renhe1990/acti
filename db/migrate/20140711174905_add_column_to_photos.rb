class AddColumnToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :column, :integer, default: 1
  end
end
