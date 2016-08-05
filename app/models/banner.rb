class Banner < ActiveRecord::Base
  acts_as_list scope: :project

  belongs_to :project

  mount_uploader :image, IconUploader
  validates :image, presence: true

  scope :global, -> { where(project_id: nil) }

  def self.policy_class
    ApplicationPolicy
  end
end
