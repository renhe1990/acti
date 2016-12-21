class Page < DatabaseConnection
  validates :title, :slug, presence: true, uniqueness: true

  def self.policy_class
    ApplicationPolicy
  end
end
