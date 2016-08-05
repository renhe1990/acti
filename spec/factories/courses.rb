FactoryGirl.define do
  factory :course do
    sequence(:name) { |n| "Course #{n}" }
    description "Course Description"
    starts_at { Time.now - 1.day }
    ends_at { Time.now + 1.day }
    public { false }
    user
  end

  factory :public_course, parent: :course do
    public { true }
  end
end
