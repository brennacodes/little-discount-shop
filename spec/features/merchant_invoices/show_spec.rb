require 'rails_helper'

RSpec.describe 'merchant invoice show page', type: :feature do
  let!(:merchant_1) { Merchant.create!(name: 'Micheal Jordan') }
  let!(:merchant_2) { Merchant.create!(name: 'John Doe') }
  let!(:item_1) { Item.create!(name: 'Item 1', description: 'Description 1', unit_price: 100, merchant_id: merchant_1.id, status: 1) }
  let!(:item_2) { Item.create!(name: 'Item 2', description: 'Description 2', unit_price: 200, merchant_id: merchant_1.id, status: 1) }
  let!(:nicole) { Customer.create!(first_name: 'Nicole', last_name: 'Smith') }
  let!(:andre) { Customer.create!(first_name: 'Andre', last_name: 'Sandre') }
  let!(:invoice_1) { Invoice.create!(customer_id: nicole.id, status: 0) }
  let!(:invoice_2) { Invoice.create!(customer_id: andre.id, status: 1) }
  let!(:invoice_3) { Invoice.create!(customer_id: andre.id, status: 2) }
  let!(:invoice1_transaction_1) { invoice_1.transactions.create!(result: 0, credit_card_number: 1234567890123456, credit_card_expiration_date: nil) }
  let!(:invoice1_transaction_2) { invoice_1.transactions.create!(result: 1, credit_card_number: 1234567890987653, credit_card_expiration_date: nil) }
  let!(:invoice_item_1) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 5, unit_price: item_1.unit_price, status: 1) }
  let!(:invoice_item_2) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 10, unit_price: item_2.unit_price, status: 1) }
  let!(:discount_1) { Discount.create!(merchant_id: merchant_1.id, percent: 20, qty_threshold: 2) }
  let!(:discount_2) { Discount.create!(merchant_id: merchant_1.id, percent: 22, qty_threshold: 10) }
  let!(:discount_invoice_item) { DiscountInvoiceItem.create!(invoice_item_id: invoice_item_1.id, discount_id: discount_1.id) }

  before(:each) do
    visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"
  end

  describe 'invoice information' do
    it 'shows the invoice info' do
      date = invoice_1.created_at.strftime("%A, %B %d, %Y")

      expect(page).to have_content(invoice_1.id)
      expect(page).to have_content(invoice_1.customer.first_name)
      expect(page).to have_content(invoice_1.customer.last_name)
      expect(page).to have_content(invoice_1.status)
      expect(page).to have_content(date)
    end

    it 'shows the invoice items info' do
      item = invoice_1.items.first
      price  = item.unit_price / 100.00

      expect(page).to have_content(item.name)
      expect(page).to have_content("$#{price}")
      expect(page).to have_content(invoice_item_1.status)
    end

    it 'can update invoice item status' do
      within "#update_#{invoice_item_1.id}_status" do
        expect(find_field('invoice_item[status]').value).not_to eq("shipped")
        
        select 'shipped', from: 'invoice_item[status]', match: :first
        
        click_on 'Update Invoice Item Status'
        
        expect(find_field('invoice_item[status]').value).to eq("shipped")
      end
    end
  end

  describe 'revenue' do
    it 'shows the invoices total revenue' do
      within "##{invoice_1.id}_total_revenue" do
        expect(page).to have_content("25.0")
      end
    end
    
    it 'shows the total discounted revenue for the merchant' do
      within "##{invoice_1.id}_total_discounted_revenue" do
        discount_1 = Discount.create!(merchant_id: merchant_1.id, percent: 20, qty_threshold: 2)
        discount_2 = Discount.create!(merchant_id: merchant_1.id, percent: 22, qty_threshold: 10)
        discount_invoice_item = DiscountInvoiceItem.create!(invoice_item_id: invoice_item_1.id, discount_id: discount_1.id)

        discounted = invoice_1.total_discounted_revenue

        expect(page).to have_content("$19.6")
      end
    end

    it 'has a link to view the bulk discount that was applied' do
      expect(page).to have_link("View Discount")

      within "#view-discount-#{discount_1.id}" do
        expect(page).to have_link("View Discount")
      end

      within "#inv-item-#{invoice_item_2.id}" do
        expect(page).not_to have_link("View Discount")
      end
    end
  end
end