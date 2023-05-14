User.create!(username: "admin", password: "password", password_confirmation: "password", email: "brennacodes+discountshop@gmail.com", role: "admin")
5.times { FactoryBot.create(:user) }
20.times { FactoryBot.create(:merchant) }
50.times { FactoryBot.create(:customer) }
60.times { FactoryBot.create(:invoice) }
70.times { FactoryBot.create(:item) }
70.times { FactoryBot.create(:invoice_item) }
10.times { FactoryBot.create(:discount) }
100.times { FactoryBot.create(:discount_invoice_item) }
