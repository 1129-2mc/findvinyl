FactoryBot.define do
  factory :release_format do
    sequence(:name) { |n| "フォーマット#{n}" }
  end
end
