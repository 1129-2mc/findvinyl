FactoryBot.define do
  factory :review do
    content { "レビュー本文" }
    association :shop
    association :user
  end

  factory :shop do
    name { "Record Shop" }
    latitude { "11223344" }
    longitude { "11223344" }
    place_id { "11223344" }
  end
end
