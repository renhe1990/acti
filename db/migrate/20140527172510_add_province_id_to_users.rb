class AddProvinceIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :province, index: true
  end
end
