class Participation < ActiveRecord::Base
  acts_as_list scope: :participateable

  belongs_to :participateable, polymorphic: true
  belongs_to :user
end
