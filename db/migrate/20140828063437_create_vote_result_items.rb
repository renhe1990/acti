class CreateVoteResultItems < ActiveRecord::Migration
  def change
    create_table :vote_result_items do |t|
      t.references :vote_result, index: true
      t.references :vote_item_option, index: true

      t.timestamps
    end
  end
end
