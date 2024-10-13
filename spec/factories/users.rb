FactoryBot.define do
  factory :user do
    name { "ユーザー名" }
    sequence(:email) { |n| "vinyllog_#{n}@example.com" }
    password { '11223344' }
    password_confirmation { '11223344' }
  end

  trait :general do
    role { :general }
  end

  trait :admin do
    role { :admin }
  end
end
