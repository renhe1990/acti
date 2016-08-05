class CreateVoteResults < ActiveRecord::Migration
  def change
    create_table :vote_results do |t|
      t.references :vote, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
