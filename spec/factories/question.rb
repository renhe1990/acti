FactoryGirl.define do
  factory :question, class: 'Survey::Question' do
    title 'Title'
    factory :rating_question do
      type 'RatingQuestion'
    end
  end
end
