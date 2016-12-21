class Feature < DatabaseConnection
  default_scope { order("features.position ASC") }

  scope :by_keyword, ->(keyword) { where("LOWER(title) LIKE ? AND project_id IS NOT NULL", "%#{keyword.downcase}%") }

  belongs_to :project

  mount_uploader :video, VideoUploader

  mount_uploader :video_screenshot, ImageUploader
  mount_uploader :cover, ImageUploader

  validates :title, presence: true

  has_many :photos, as: :photoable
  accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? && attributes['image'].blank? }

  acts_as_list

  scope :global, -> { where(project_id: nil) }

  def self.policy_class
    ApplicationPolicy
  end

  def self.admin_search(keyword, options = {})
    by_keyword(keyword).includes(:project).joins(:project)
  end
end
