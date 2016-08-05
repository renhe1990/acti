class CreateVoteItemOptions < ActiveRecord::Migration
  def change
    create_table :vote_item_options do |t|
      t.references :vote_item, index: true
      t.text :text
      t.references :user, index: true

      t.timestamps
    end
  end
end
