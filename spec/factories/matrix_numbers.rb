FactoryBot.define do
  factory :matrix_number do
    sequence(:number) { |n| "マトリクスナンバー#{n}" }
  end
end
