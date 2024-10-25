FactoryBot.define do
  factory :press_country do
    sequence(:name) { |n| "プレス国#{n}" }
  end
end
