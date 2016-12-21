class Review < DatabaseConnection
  belongs_to :context, polymorphic: true
  belongs_to :reviewable, polymorphic: true
  belongs_to :reviewer, polymorphic: true

  validates :reviewable, presence: true
  validates :reviewer, presence: true
  validates :context, presence: true

  belongs_to :user, -> { where(reviews: {reviewer_type: 'User'}) }, foreign_key: 'reviewer_id'

  belongs_to :attempt, class_name: 'Survey::Attempt'
  has_many :answers, class_name: 'Survey::Answer', dependent: :delete_all
  accepts_nested_attributes_for :answers,
    :reject_if => ->(q) { q[:question_id].blank? || (q[:option_id].blank? && q[:text].blank? && q[:rating].blank?) },
    allow_destroy: true
end
