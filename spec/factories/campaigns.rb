FactoryGirl.define do
  factory :campaign do
    sequence(:name) { |n| "Campaign #{n}" }
    location { "Location" }
    starts_at { Time.now - 5.days }
    ends_at { Time.now + 5.days }
    project
  end
end
