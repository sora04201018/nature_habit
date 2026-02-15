FactoryBot.define do
  factory :habit_check do
    association :user
    association :habit
    checked_on { Date.current }
  end
end
