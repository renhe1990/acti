class OpinionnaireReviewee < DatabaseConnection
  default_scope { order('position ASC') }
  acts_as_list scope: :opinionnaire

  belongs_to :opinionnaire
  belongs_to :reviewee, class_name: 'User'
end
