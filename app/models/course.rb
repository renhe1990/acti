class Course < DatabaseConnection
  default_scope { order("courses.position ASC") }

  extend Enumerize

  extend SimpleCalendar
  has_calendar

  validates :name, presence: true
  validates :starts_at, :ends_at, presence: true, date: true, unless: Proc.new { |course| course.public || course.public_course }
  validates :ends_at, date: { after_or_equal_to: :starts_at }, unless: Proc.new { |course| course.public || course.public_course }

  validate :starts_at_must_be_valid, if: Proc.new { |course| course.campaign.present? }
  validate :ends_at_must_be_valid, if: Proc.new { |course| course.campaign.present? }

  enumerize :genre, in: ['销售技巧', '礼仪修养', '企业文化', '顾客关系', '沟通技能', '产品知识', '会议技巧', '辅助工具'], scope: true
  enumerize :hour, in: ['1课时以下', '1课时', '2课时', '3课时', '4课时', '4课时以上'], scope: true

  belongs_to :campaign
  has_many :lessons, dependent: :delete_all

  belongs_to :user
  belongs_to :public_course, class_name: 'Course'

  has_many :surveys, class_name: 'Survey::Survey', dependent: :destroy
  has_many :polls
  has_many :questionnaires
  has_many :opinionnaires

  has_many :draws, dependent: :destroy
  has_many :lucky_draws
  has_many :speech_draws
  has_many :debate_draws

  has_many :votes, dependent: :destroy

  has_many :attachments, as: :attachable, dependent: :delete_all

  has_many :participations, as: :participateable, dependent: :delete_all
  has_many :users, through: :participations

  has_many :course_lecturers, dependent: :delete_all
  has_many :lecturers, through: :course_lecturers

  scope :by_name, ->(name) { where("name LIKE ?", "%#{name}%") }

  scope :by_month, ->(date) {
    where("starts_at > ? AND starts_at < ?", date.beginning_of_month, date.end_of_month)
  }

  scope :pending, -> { where("starts_at > ? OR starts_at IS NULL OR ends_at IS NULL", Date.today) }
  scope :completed, -> { where("ends_at < ?", Date.today) }
  scope :ongoing, -> { where("starts_at >= ? AND ends_at <= ?", Date.today, Date.today) }

  scope :common, -> { where("public = ?", true) }

  STATES = %w(pending ongoing completed)

  scope :by_keyword, ->(keyword) { where("LOWER(name) LIKE ?", "%#{keyword.downcase}%").where.not(campaign_id: nil) }

  def days
    (self.ends_at - self.starts_at).round + 1
  end

  alias_method :original_users, :users
  def users
    self.original_users.blank? ? campaign.try(:project).try(:users) : self.original_users
  end

  def copy(attrs = {})
    course = deep_clone include: { :polls => { :questions => :options }, :questionnaires => { :questions => :options } }
    course.assign_attributes attrs
    course.save

    course
  end

  def self.policy_class
    ApplicationPolicy
  end

  def self.admin_search(keyword, options = {})
    joins(:campaign => :project).includes(:campaign => :project).where("campaigns.project_id IS NOT NULL").where("LOWER(courses.name) LIKE ?", "%#{keyword.downcase}%").where("courses.public IS NULL OR courses.public != 1")
  end

  def self.search(keyword = '', options = {})
    scope = where("LOWER(name) LIKE ?", "%#{keyword.downcase}%")
    scope = scope.where(public: true) if options[:public].present?
    scope = scope.with_genre(options[:genre]) if options[:genre].present?
    scope = scope.with_hour(options[:hour]) if options[:hour].present?

    if options[:survey_count].present?
      scope = case options[:survey_count].to_i
              when 1
                scope.where("survey_count > 0")
              when 0
                scope.where("survey_count < 1")
              end
    end

    scope.page(options[:page])
  end

  private
  def starts_at_must_be_valid
    if !starts_at.between?(campaign.starts_at, campaign.ends_at)
      self.errors.add :starts_at, I18n.t('errors.messages.between', start_date: campaign.starts_at, end_date: campaign.ends_at)
    end
  end

  def ends_at_must_be_valid
    if !ends_at.between?(campaign.starts_at, campaign.ends_at)
      self.errors.add :ends_at, I18n.t('errors.messages.between', start_date: campaign.starts_at, end_date: campaign.ends_at)
    end
  end
end
