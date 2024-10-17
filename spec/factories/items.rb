FactoryBot.define do
  factory :item do
    association :title
    association :artist_name
    association :release_format
    association :press_country
    association :matrix_number
    condition_id { Condition.pluck(:id).sample }
    user_note { "メモ" }
    status { "active" }
    association :user

    trait :collection do
      role { :collection }
    end

    trait :want do
      role { :want }
    end

    after(:build) do |item|
      item.tags = create_list(:tag, 3)
    end

    after(:create) do |item|
      item.accessories << Accessory.order("RANDOM()").limit(2)
    end
  end
end
