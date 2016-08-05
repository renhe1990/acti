class AddAttemptIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :attempt_id, :integer, index: true
  end
end
