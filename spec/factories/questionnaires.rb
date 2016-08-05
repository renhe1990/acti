FactoryGirl.define do
  factory :questionnaire do
    sequence(:name) { |n| "Questionnaire #{n}" }
    description "Questionnaire Description"
    comment "Questionnaire Comment"
    course
  end
end
