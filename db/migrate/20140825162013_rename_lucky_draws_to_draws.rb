class RenameLuckyDrawsToDraws < ActiveRecord::Migration
  def change
    rename_table :lucky_draws, :draws
    add_column :draws, :type, :string
  end
end
