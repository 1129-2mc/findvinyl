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

  factory :title do
    name { "タイトル" }
  end

  factory :artist_name do
    name { "アーティスト" }
  end

  factory :release_format do
    name { "フォーマット" }
  end

  factory :press_country do
    name { "プレス国" }
  end

  factory :matrix_number do
    number { "1000" }
  end

  factory :tag do
    sequence(:name) { |n| "タグ#{n}" }
  end
end
