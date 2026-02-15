FactoryBot.define do
  factory :habit do
    title { "テスト" }
    association :user
  end
end
