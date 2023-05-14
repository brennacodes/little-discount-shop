User.create!(username: "admin", password: "password", password_confirmation: "password", email: "brennacodes+discountshop@gmail.com", role: "admin")
5.times { FactoryBot.build(:user) }
20.times { FactoryBot.build(:merchant) }
50.times { FactoryBot.build(:customer) }
60.times { FactoryBot.build(:invoice) }
70.times { FactoryBot.build(:item) }
70.times { FactoryBot.build(:invoice_item) }
10.times { FactoryBot.build(:discount) }
100.times { FactoryBot.build(:discount_invoice_item) }
