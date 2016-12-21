class Participation < DatabaseConnection
  acts_as_list scope: :participateable

  belongs_to :participateable, polymorphic: true
  belongs_to :user
end
