class Event < ActiveRecord::Base
  default_scope { order("starts_at ASC") }

  validates :name, presence: true

  validates :starts_at, :ends_at, presence: true
  validates :ends_at, date: { after_or_equal_to: :starts_at }

  validate :starts_at_must_be_valid
  validate :ends_at_must_be_valid

  belongs_to :schedule

  has_many :participations, as: :participateable
  has_many :users, through: :participations

  accepts_nested_attributes_for :users

  def self.policy_class
    ApplicationPolicy
  end

  def days
    @days ||= (ends_at.to_date - starts_at.to_date).to_i + 1
  end

  protected
  def starts_at_must_be_valid
    if !starts_at.between?(schedule.date.beginning_of_day, schedule.date.end_of_day)
      self.errors.add :starts_at, I18n.t('errors.messages.between', start_date: schedule.date, end_date: schedule.date)
    end
  end

  def ends_at_must_be_valid
    if !ends_at.between?(schedule.date.beginning_of_day, schedule.date.end_of_day)
      self.errors.add :ends_at, I18n.t('errors.messages.between', start_date: schedule.date, end_date: schedule.date)
    end
  end
end
