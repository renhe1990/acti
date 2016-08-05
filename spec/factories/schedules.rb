FactoryGirl.define do
  factory :schedule do
    sequence(:title) { |n| "Schedule #{n}" }
    date { Time.now }
    campaign
  end
end
