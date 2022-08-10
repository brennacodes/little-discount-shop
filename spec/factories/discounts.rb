FactoryBot.define do
  factory :discount do
    merchant_id { rand(1..50) }
    percent { rand(1..99) }
    qty_threshold { rand(2..50) }
    holiday_date { Faker::Date.between(from: Date.today + 10, to: Date.today + 365) }
    name { Holidays.year_holidays([:us]).sample[:name] }
    created_at { Faker::Date.between(from: Date.today - 100, to: Date.today) }
    updated_at { Faker::Date.between(from: Date.today - 100, to: Date.today) }
  end
end