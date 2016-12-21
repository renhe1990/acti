class VoteResultItem < DatabaseConnection
  belongs_to :vote_result
  belongs_to :vote_item_option
end
