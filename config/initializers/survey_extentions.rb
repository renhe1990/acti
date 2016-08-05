Survey::Attempt.class_eval do
  belongs_to :surveyable, polymorphic: true
  has_many :reviews, dependent: :destroy
end

Survey::Option.class_eval do
  acts_as_list scope: :question
end

Survey::Answer.class_eval do
  belongs_to :review
end
