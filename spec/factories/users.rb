FactoryBot.define do
  factory :user do
    username { "test" }
    sequence(:email) { |n| "sample#{n}@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end
end
