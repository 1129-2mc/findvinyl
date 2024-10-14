FactoryBot.define do
  factory :item do
    association :title
    association :artist_name
    association :release_format
    association :press_country
    association :matrix_number
    condition_id { Condition.pluck(:id).sample }
    user_note { "メモ" }
    role { "collection" }
    status { "active" }
    association :user

    after(:build) do |item|
      item.tags = create_list(:tag, 3)
    end

    after(:create) do |item|
      item.accessories << Accessory.order("RANDOM()").limit(2)
    end
  end
end
