class VoteResult < DatabaseConnection
  belongs_to :vote
  belongs_to :user

  has_many :vote_result_items
  accepts_nested_attributes_for :vote_result_items
end
