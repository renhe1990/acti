FactoryGirl.define do
  factory :cell do
    sequence(:title) {|n| "Title #{n}" }
    project
  end
end
