class CreateVoteItems < ActiveRecord::Migration
  def change
    create_table :vote_items do |t|
      t.string :title
      t.text :description
      t.references :vote, index: true
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
