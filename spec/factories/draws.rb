FactoryGirl.define do
  factory :draw do
    sequence(:title) { |n| "Draw #{n}" }
    course
    factory :lucky_draw do
      type 'LuckyDraw'
    end
    factory :speech_draw do
      type 'SpeechDraw'
    end
    factory :debate_draw do
      type 'DebateDraw'
    end
  end
end

