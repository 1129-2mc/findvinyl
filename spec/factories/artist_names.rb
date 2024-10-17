FactoryBot.define do
  factory :artist_name do
    sequence(:name) { |n| "アーティスト#{n}" }
  end
end
