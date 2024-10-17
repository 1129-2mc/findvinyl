FactoryBot.define do
  factory :title do
    sequence(:name) { |n| "タイトル#{n}" }
  end
end
