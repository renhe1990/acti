FactoryGirl.define do
  factory :opinionnaire do
    sequence(:name) { |n| "Opionionnaire #{n}" }
    description "Opinionnaire Description"
    comment "Opinionnaire Comment"
    course
  end
end
