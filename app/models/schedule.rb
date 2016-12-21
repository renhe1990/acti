class Schedule < DatabaseConnection
  include Sortable
  belongs_to :campaign

  has_many :events, dependent: :delete_all
  has_many :activities
  has_many :lessons

  validates :title, presence: true
  validates :date, presence: true, date: true, uniqueness: { scope: :campaign_id }
  validate :date_must_be_valid

  def self.policy_class
    ApplicationPolicy
  end

  private
  def date_must_be_valid
    if !date.between?(campaign.starts_at, campaign.ends_at)
      self.errors.add :date, I18n.t('errors.messages.between', start_date: campaign.starts_at, end_date: campaign.ends_at)
    end
  end
end
