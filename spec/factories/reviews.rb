FactoryBot.define do
  factory :review do
    content { "レビュー本文" }
    association :shop
    association :user
  end
end
