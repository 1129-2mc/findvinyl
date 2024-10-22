FactoryBot.define do
  factory :record do
    content  { '本文' }
    association :user

    trait :with_item do
      after(:create) do |record, evaluator|
        record.items << create(:item)
      end
    end
  end
end
