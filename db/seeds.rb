User.create!(username: "admin", password_digest: "password", email: "brennacodes+discountshop@gmail.com", role: "admin")
20.times { FactoryBot.create(:merchant) }
40.times { FactoryBot.create(:item) }
50.times { FactoryBot.create(:invoice_item) }
10.times { FactoryBot.create(:discount) }
100.times { FactoryBot.create(:discount_invoice_item) }
