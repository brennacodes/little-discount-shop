User.create!(username: "admin", password_digest: "password", email: "brennacodes+discountshop@gmail.com", role: "admin")
20.times { FactoryBot.create(:merchant) }
20.times { FactoryBot.create(:item) }
20.times { FactoryBot.create(:invoice_item) }
20.times { FactoryBot.create(:discount) }
20.times { FactoryBot.create(:discount_invoice_item) }
