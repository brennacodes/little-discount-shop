FactoryBot.define do
  factory :item do
    merchant
    name { Faker::Commerce.product_name }
    description { Faker::Restaurant.review }
    unit_price { Faker::Commerce.price(range: 0..50.0, as_string: false) }
    status { [0, 1].sample }
  end
end