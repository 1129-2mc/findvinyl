FactoryBot.define do
  factory :record do
    content  { '本文' }
    association :user

    after(:build) do |record|
      record.items << build_stubbed(:item)
    end
  end
end
