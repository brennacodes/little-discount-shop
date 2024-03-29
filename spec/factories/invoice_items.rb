FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { rand(5...30) }
    unit_price { Faker::Commerce.price(range: 0..50.0, as_string: false) }
    status { [0, 1, 2].sample }
  end
end