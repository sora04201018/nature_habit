FactoryBot.define do
  factory :comment do
    body { "テスト本文" }
    association :user
    association :commentable, factory: :post
  end
end