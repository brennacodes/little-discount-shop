require 'rails_helper'

RSpec.describe 'admin invoices show page' do
  let!(:merchant_1) { Merchant.create!(name: 'Merchant 1') }
  let!(:merchant_2) { Merchant.create!(name: 'Merchant 2') }
  let!(:item_1) { Item.create!(name: 'Crazy cats', description: 'Item 1 description', unit_price: 100, merchant_id: merchant_1.id) }
  let!(:item_2) { Item.create!(name: 'Loony leopards', description: 'Item 2 description', unit_price: 200, merchant_id: merchant_1.id) }
  let!(:item_3) { Item.create!(name: 'Pretty pandas', description: 'Item 3 description', unit_price: 300, merchant_id: merchant_2.id) }
  let!(:sally) { Customer.create!(first_name: 'Sally', last_name: 'Sunshine') }
  let!(:invoice_1) { Invoice.create!(customer_id: sally.id, status: 1) }
  let!(:invoice_2) { Invoice.create!(customer_id: sally.id, status: 1) }
  let!(:invoice_item_1) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 100, status: 1) }
  let!(:invoice_item_2) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 2, unit_price: 200, status: 1) }
  let!(:invoice_item_3) { InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 300, status: 1) }
  #  before :each do
  #     @merchant_1 = Merchant.create!(name: "merchant_1")

  #     @item_1 = @merchant_1.items.create!(name: "Item 1", description: "its the 1st item", unit_price: 10000)
  #     @item_2 = @merchant_1.items.create!(name: "Item 2", description: "its the 2nd item", unit_price: 2000)
  #     @item_3 = @merchant_1.items.create!(name: "Item 3", description: "its the 3rd item", unit_price: 300)

  #     sally = Customer.create!(first_name: "Sally", last_name: "Sunshine")

  #     invoice_1 = sally.invoices.create!(status: 1)
  #     invoice_2 = sally.invoices.create!(status: 1)

  #     invoice_items_1 = @item_1.invoice_items.create!(quantity: 1, unit_price: 10000, status: "pending", invoice_id: invoice_1.id)
  #     invoice_items_2 = @item_2.invoice_items.create!(quantity: 1, unit_price: 2000, status: "pending", invoice_id: invoice_2.id)
  #     invoice_items_3 = @item_3.invoice_items.create!(quantity: 1, unit_price: 300, status: "pending", invoice_id: invoice_1.id)
      
  #  end
  before do
    visit "/admin/invoices/#{invoice_1.id}"
  end

   it 'invoice show page includes invoice id, status, created_at date, and customers name' do
      expect(page).to have_content("Invoice ID: #{invoice_1.id}")
      expect(page).to have_content("Status: #{invoice_1.status}")
      expect(page).to have_content("Customer's Full Name: #{sally.first_name} #{sally.last_name}")
      
      expect(page).to_not have_content("Invoice ID: #{invoice_2.id}")
      expect(page).to_not have_content("Invoice Status: #{invoice_2.status}")
  end

  it "has all items on the invoice w/item name, quantity, price, and invoice item status" do
    within "#item-#{invoice_item_1.id}" do
      expect(page).to have_content("Crazy cats")
      expect(page).to have_content("1")
      expect(page).to have_content("$1.0")
      expect(page).to have_content("packaged")
    end

    within "#item-#{invoice_item_2.id}" do
      expect(page).to have_content("Loony leopards")
      expect(page).to have_content("2")
      expect(page).to have_content("$2.0")
      expect(page).to have_content("packaged")
    end

    within "#item-#{invoice_item_3.id}" do
      expect(page).to have_content("Pretty pandas")
      expect(page).to have_content("3")
      expect(page).to have_content("$3.0")
      expect(page).to have_content("packaged")
    end
  end

  it 'shows the total revenue from all items on specific invoice' do
      expect(page).to have_content("Total Revenue: $14.0")
  end

   it 'shows invoice status is a select field' do
      expect(page).to have_content("in progress")

      select "completed", from: :status
      
      click_button "Update Status"
      expect(page).to have_content("completed")
   end

   it 'shows the total revenue and the discounted revenue if applicable' do
      # When I visit an admin invoice show page
      # Then I see the total revenue from this invoice (not including discounts)
      # And I see the total discounted revenue from this invoice which includes bulk discounts in the calculation
    end
end


