class VoteItemOption < ActiveRecord::Base
  belongs_to :vote_item
  belongs_to :user

  has_many :vote_result_items

  def display_text
    user.try(:name) || self.text
  end
end
