FactoryGirl.define do
  factory :poll do
    sequence(:name) { |n| "Poll #{n}" }
    description "Poll Description"
    comment "Poll Comment"
    course
  end
end
