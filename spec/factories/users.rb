FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password_digest { "password" }
    role { 1 }
  end
end
