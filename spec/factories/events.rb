FactoryGirl.define do
  factory :event do
    name "Name"
    starts_at { Time.now - 3.days }
    ends_at { Time.now + 3.days }
    schedule
    factory :lesson do
      type 'Lesson'
    end
    factory :activity do
      type 'Activity'
    end
  end
end
