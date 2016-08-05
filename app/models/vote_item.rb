class VoteItem < ActiveRecord::Base
  acts_as_list scope: :vote
  belongs_to :vote

  has_many :vote_item_options
  accepts_nested_attributes_for :vote_item_options,
    reject_if: ->(vote_item_option) { vote_item_option[:text].blank? },
    allow_destroy: true

  validates :title, presence: true
end
