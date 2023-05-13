FactoryBot.define do
  factory :item do
    name { Faker::Company.name }
    status { [0, 1].sample }
  end
end