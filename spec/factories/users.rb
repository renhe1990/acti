FactoryGirl.define do
  factory :user do
    sequence(:card_number) { |n| "#{n}" }
    sequence(:name) { |n| "Name #{n}" }
    sequence(:email) { |n| "test#{n}@test.com" }
    password "password"
    password_confirmation "password"
  end
end
