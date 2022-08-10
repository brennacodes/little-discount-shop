FactoryBot.define do
  factory :discount_invoice_item do
    discount_id { rand(5..25) }
    invoice_item_id { rand(5..25) }
  end
end
