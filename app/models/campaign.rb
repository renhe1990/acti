class Campaign < ActiveRecord::Base
  default_scope { order("campaigns.position ASC") }
  scope :by_keyword, ->(keyword) { where("LOWER(campaigns.name) LIKE ?", "%#{keyword.downcase}%") }

  belongs_to :project

  has_many :schedules, dependent: :destroy
  has_many :events, through: :schedules

  has_many :courses, dependent: :destroy

  validates :name, :location, presence: true

  validates :starts_at, :ends_at, presence: true, date: true
  validates :ends_at, date: { after_or_equal_to: :starts_at }

  def self.policy_class
    ApplicationPolicy
  end

  def self.admin_search(keyword, options = {})
    by_keyword(keyword).includes(:project).joins(:project)
  end
end
