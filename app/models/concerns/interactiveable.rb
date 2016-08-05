module Interactiveable
  extend ActiveSupport::Concern
  include Searchable

  included do
    belongs_to :course
    belongs_to :user

    has_many :participations, as: :participateable
    has_many :users, through: :participations

    scope :with_admin_course, -> { joins(:course).where("courses.campaign_id IS NOT NULL") }

    is_impressionable counter_cache: true

    after_create do
      if course
        Course.increment_counter(:survey_count, course.id)
      end
    end

    after_destroy do
      if course
        Course.decrement_counter(:survey_count, course.id)
      end
    end

    alias_method :original_users, :users
    define_method :users do
      (self.original_users.blank? ? course.users : self.original_users) || []
    end
  end

  def started?
    course.starts_at > Date.today
  end
end


