class AddStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :integer, index: true, default: 0
  end
end
