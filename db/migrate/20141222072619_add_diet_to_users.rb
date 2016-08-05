class AddDietToUsers < ActiveRecord::Migration
  def change
    add_column :users, :diet, :integer
  end
end
