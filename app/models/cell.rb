class Cell < ActiveRecord::Base
  default_scope { order("cells.position ASC") }

  acts_as_list scope: :project

  belongs_to :project

  mount_uploader :icon, IconUploader
  validates :title, presence: true, uniqueness: { scope: :project_id }

  # validates :url, presence: true, unless: :editable

  scope :active, -> { where(active: true) }
  scope :root, -> { where(project_id: nil) }

  COLORS = %w(#9062dc #6e8ade #43aae4 #1bc968 #83d238 #f1b636 #fc8953)
  MODE6_COLORS = %w(#eaa640 #d87e3b #e5693f #d97458 #c0765c #c5665c #9f5161 #8f4d77 #884e8c)

  def self.policy_class
    ApplicationPolicy
  end
end
