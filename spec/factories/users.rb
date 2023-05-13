FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    role { 1 }
  end
end
