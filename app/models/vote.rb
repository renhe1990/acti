class Vote < ActiveRecord::Base
  include Interactiveable

  belongs_to :course

  validates :title, presence: true

  has_many :vote_items, dependent: :delete_all
  accepts_nested_attributes_for :vote_items,
    reject_if: ->(vote_item) { vote_item[:title].blank? },
    allow_destroy: true

  has_many :vote_results, dependent: :delete_all

  def self.policy_class
    ApplicationPolicy
  end

  def create_worksheets(book)
    sheet = book.create_worksheet

    sheet.row(0).push self.title
    sheet.row(1).push self.description

    sheet.row(3).push '学员'
    vote_items.each do |vote_item|
      sheet.row(3).push vote_item.title
    end

    vote_results.each_with_index do |vote_result, index|
      sheet.row( 4 + index).push vote_result.user.name
      vote_items.each do |vote_item|
        sheet.row( 4 + index).push vote_answers_in_xls(vote_result, vote_item)
      end
    end
  end

  def vote_answers_in_xls(vote_result, vote_item)
    result = vote_item.vote_item_options & vote_result.vote_result_items.map(&:vote_item_option)
    if result.present?
      result.first.text
    else
      '/'
    end
  end
end
