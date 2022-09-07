require 'rails_helper'

RSpec.describe 'admin dashboard' do
  include ApplicationHelper

  let!(:merchant_1) { Merchant.create!(name: 'Merchant 1') }
  let!(:merchant_2) { Merchant.create!(name: 'Merchant 2') }

  let!(:customer_1) { Customer.create!(first_name: "Sally", last_name: "Sunshine") }
  let!(:customer_2) { Customer.create!(first_name: "Henry", last_name: "Hill") }
  let!(:customer_3) { Customer.create!(first_name: "Tom", last_name: "Thunder") }
  let!(:customer_4) { Customer.create!(first_name: "Mary", last_name: "Mountain") }
  let!(:customer_5) { Customer.create!(first_name: "Riley", last_name: "Rain") }

  let!(:invoice_1) { Invoice.create!(status: 0, customer_id: customer_1.id) }
  let!(:invoice_2) { Invoice.create!(status: 1, customer_id: customer_1.id) }
  let!(:invoice_3) { Invoice.create!(status: 1, customer_id: customer_2.id) }
  let!(:invoice_4) { Invoice.create!(status: 1, customer_id: customer_3.id) }
  let!(:invoice_5) { Invoice.create!(status: 1, customer_id: customer_4.id) }
  let!(:invoice_6) { Invoice.create!(status: 1, customer_id: customer_5.id) }
  let!(:invoice_7) { Invoice.create!(status: 2, customer_id: customer_1.id) }
  let!(:invoice_8) { Invoice.create!(status: 2, customer_id: customer_2.id) }
  let!(:invoice_9) { Invoice.create!(status: 2, customer_id: customer_3.id) }
  let!(:invoice_10) { Invoice.create!(status: 2, customer_id: customer_4.id) }

  let!(:item_1) { Item.create!(name: "Item 1", description: "Description 1", unit_price: 100, merchant_id: merchant_1.id) }
  let!(:item_2) { Item.create!(name: "Item 2", description: "Description 2", unit_price: 200, merchant_id: merchant_1.id) }
  let!(:item_3) { Item.create!(name: "Item 3", description: "Description 3", unit_price: 300, merchant_id: merchant_1.id) }
  let!(:item_4) { Item.create!(name: "Item 4", description: "Description 4", unit_price: 400, merchant_id: merchant_1.id) }

  let!(:invoice_item_1) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 100, status: 0) }
  let!(:invoice_item_2) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 200, status: 0) }
  let!(:invoice_item_3) { InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_2.id, quantity: 1, unit_price: 300, status: 1) }
  let!(:invoice_item_4) { InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_2.id, quantity: 1, unit_price: 400, status: 1) }
  let!(:invoice_item_5) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_3.id, quantity: 1, unit_price: 100, status: 2) }
  let!(:invoice_item_6) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_3.id, quantity: 1, unit_price: 200, status: 2) }

  let!(:transaction_1) { Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "123456789") }
  let!(:transaction_2) { Transaction.create!(result: 0, invoice_id: invoice_2.id, credit_card_number: "123456789") }
  let!(:transaction_3) { Transaction.create!(result: 0, invoice_id: invoice_3.id, credit_card_number: "123456789") }
  let!(:transaction_4) { Transaction.create!(result: 0, invoice_id: invoice_4.id, credit_card_number: "123456789") }
  let!(:transaction_5) { Transaction.create!(result: 0, invoice_id: invoice_5.id, credit_card_number: "123456789") }
  let!(:transaction_6) { Transaction.create!(result: 0, invoice_id: invoice_6.id, credit_card_number: "123456789") }
  let!(:transaction_7) { Transaction.create!(result: 0, invoice_id: invoice_7.id, credit_card_number: "123456789") }
  let!(:transaction_8) { Transaction.create!(result: 0, invoice_id: invoice_8.id, credit_card_number: "123456789") }
  let!(:transaction_9) { Transaction.create!(result: 0, invoice_id: invoice_9.id, credit_card_number: "123456789") }
  let!(:transaction_10) { Transaction.create!(result: 0, invoice_id: invoice_10.id, credit_card_number: "123456789") }
  let!(:transaction_11) { Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "123456789") }
  let!(:transaction_12) { Transaction.create!(result: 0, invoice_id: invoice_2.id, credit_card_number: "123456789") }
  let!(:transaction_13) { Transaction.create!(result: 0, invoice_id: invoice_3.id, credit_card_number: "123456789") }
  let!(:transaction_14) { Transaction.create!(result: 0, invoice_id: invoice_4.id, credit_card_number: "123456789") }
  let!(:transaction_15) { Transaction.create!(result: 0, invoice_id: invoice_5.id, credit_card_number: "123456789") }
  let!(:transaction_16) { Transaction.create!(result: 0, invoice_id: invoice_6.id, credit_card_number: "123456789") }
  let!(:transaction_17) { Transaction.create!(result: 0, invoice_id: invoice_7.id, credit_card_number: "123456789") }
  let!(:transaction_18) { Transaction.create!(result: 0, invoice_id: invoice_8.id, credit_card_number: "123456789") }
  let!(:transaction_19) { Transaction.create!(result: 0, invoice_id: invoice_9.id, credit_card_number: "123456789") }
  let!(:transaction_20) { Transaction.create!(result: 0, invoice_id: invoice_10.id, credit_card_number: "123456789") }
  let!(:transaction_21) { Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "123456789") }
  let!(:transaction_22) { Transaction.create!(result: 0, invoice_id: invoice_2.id, credit_card_number: "123456789") }
  let!(:transaction_23) { Transaction.create!(result: 0, invoice_id: invoice_3.id, credit_card_number: "123456789") }
  let!(:transaction_24) { Transaction.create!(result: 0, invoice_id: invoice_4.id, credit_card_number: "123456789") }
  let!(:transaction_25) { Transaction.create!(result: 0, invoice_id: invoice_5.id, credit_card_number: "123456789") }
  let!(:transaction_26) { Transaction.create!(result: 0, invoice_id: invoice_6.id, credit_card_number: "123456789") }
  let!(:transaction_27) { Transaction.create!(result: 0, invoice_id: invoice_7.id, credit_card_number: "123456789") }
  let!(:transaction_28) { Transaction.create!(result: 0, invoice_id: invoice_8.id, credit_card_number: "123456789") }
  let!(:transaction_29) { Transaction.create!(result: 0, invoice_id: invoice_9.id, credit_card_number: "123456789") }

  before do
    @admin = User.create!(username: "Admin", email: "admin@admin.com", password: "admin", role: 2)

    visit root_path

    fill_in :username, with: @admin.username
    fill_in :password, with: @admin.password

    click_button "Login", match: :first

    click_on "Admin Dashboard"
  end

  it 'has a header titled admin dashboard' do
    expect(page).to have_content("Dashboard")
  end

  it 'has a link to the admin merchants index (/admin/merchants)' do
    click_on 'Merchants'

    expect(current_path).to eq(admin_merchants_path)
  end

  it 'has a link to the admin merchants index (/admin/invoices)' do
    click_on 'Invoices'

    expect(current_path).to eq(admin_invoices_path)
  end

  describe 'dashboard statistics - top customers' do
    it 'displays the names of the top 5 customers' do      
      expect(page).to have_content("Top 5 Customers")

      within '#top-5-customers' do
        expect(page).to have_content("Name: Sally Sunshine")
        expect(page).to have_content("Name: Henry Hill")
        expect(page).to have_content("Name: Tom Thunder")
        expect(page).to have_content("Name: Mary Mountain")
        expect(page).to have_content("Name: Riley Rain")
      end
    end
  end

  describe 'Admin Dashboard Invoices' do
    it 'has the "Incomplete Invoices" section w/ list of IDs for all invoices with unshipped items' do
      expect(page).to have_content("Incomplete Invoices")

      within '#incomplete-invoices' do
        expect(page).to have_content("Invoice ##{invoice_1.id}")
        expect(page).to have_content("Invoice ##{invoice_2.id}")
        expect(page).not_to have_content("Invoice ##{invoice_3.id}")
      end
    end

    it 'invoices are sorted by least recent' do
      expect(page).to have_content(format_date(invoice_3.created_at))
      expect(page).to have_content(format_date(invoice_2.created_at))
      expect(page).to have_content(format_date(invoice_1.created_at))
    end
  end
end