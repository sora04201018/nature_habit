FactoryBot.define do
  factory :notification do
    association :visitor, factory: :user
    association :visited, factory: :user
    association :notifiable, factory: :comment
    action { "comment" }
  end
end