class AddGradeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :grade_id, :integer, index: true
  end
end
