class AddGenderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :integer, index: true
  end
end
