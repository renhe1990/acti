FactoryGirl.define do
  factory :vote do
    sequence(:title) { |n| "Vote #{n}" }
    description "Vote Description"
    course
  end
end
