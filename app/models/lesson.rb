class Lesson < Event
  belongs_to :schedule
  belongs_to :course
  belongs_to :user

  after_commit :save_course, on: :create, if: Proc.new{ |lesson| lesson.course.nil? }

  scope :by_name, ->(name) { where("name LIKE ?", "%#{name}%") }
  scope :pending, -> { where("starts_at > ?", Time.now) }
  scope :completed, -> { where("ends_at < ?", Time.now) }

  private
  def save_course
    if schedule
      self.course = schedule.campaign.courses.create(name: self.name, description: self.description, starts_at: self.starts_at.try(:to_date), ends_at: self.ends_at.try(:to_date))
    else
      # FIXME: create_course should create course and link the lesson.
      self.course = create_course(name: self.name, description: self.description, starts_at: self.starts_at.try(:to_date), ends_at: self.ends_at.try(:to_date))
    end
    self.save
  end

  def starts_at_must_be_valid
    return if schedule.nil?

    if course
      if !starts_at.between?(course.starts_at.beginning_of_day, course.ends_at.end_of_day)
        self.errors.add :starts_at, I18n.t('errors.messages.between', start_date: course.starts_at, end_date: course.ends_at)
      end
    end
  end

  def ends_at_must_be_valid
    return if schedule.nil?

    if course
      if !ends_at.between?(course.starts_at.beginning_of_day, course.ends_at.end_of_day)
        self.errors.add :ends_at, I18n.t('errors.messages.between', start_date: course.starts_at, end_date: course.ends_at)
      end
    end
  end
end
