class AddColumnsToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :columns, :integer, default: 1
  end
end
