require 'rails_helper'

RSpec.describe 'merchant discounts index page', type: :feature do
  let!(:merchant) { Merchant.create!(name: 'Merchant 1') }
  let!(:item_1) { merchant.items.create!(name: 'Item 1', description: 'Item 1 description', unit_price: '100') }
  let!(:customer) { Customer.create!(first_name: 'John', last_name: 'Doe') }
  let!(:invoice) { Invoice.create!(customer_id: customer.id, status: 'in progress') }
  let!(:invoice_1) { Invoice.create!(customer_id: customer.id, status: 'in progress') }
  let!(:invoice_item_1) { InvoiceItem.create!(invoice_id: invoice.id, item_id: item_1.id, quantity: 10, unit_price: 100, status: 1) }
  let!(:invoice_item_2) { InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 7, unit_price: 222, status: 0) }
  let!(:discount) { Discount.create!(merchant_id: merchant.id, name: 'Sale sale sale!', percent: 77, qty_threshold: 8) }
  let!(:discount_1) { Discount.create!(merchant_id: merchant.id, name: 'HOLIDAYS!', percent: 55, qty_threshold: 15) }
  let!(:discount_invoice_item_2) { DiscountInvoiceItem.create!(discount_id: discount_1.id, invoice_item_id: invoice_item_2.id) }

  before do
    visit "/merchants/#{merchant.id}/discounts/#{discount.id}"
  end

  describe 'links' do
    it 'has a link to edit a discount' do
      expect(page).to have_link('Edit Bulk Discount')

      click_link 'Edit Bulk Discount'

      expect(current_path).to eq("/merchants/#{merchant.id}/discounts/#{discount.id}/edit")
    end

    it 'does not have a link to edit a discount if it has pending invoices' do
      visit "/merchants/#{merchant.id}/discounts/#{discount_1.id}"
      
      expect(page).not_to have_link('Edit Bulk Discount')
    end
  end

  describe 'information' do
    it 'displays the discounts percentage and quantity threshold' do
      expect(page).to have_content("#{discount.percent}%")
      expect(page).to have_content("#{discount.qty_threshold}")

      expect(page).not_to have_content("#{discount_1.percent}%")
      expect(page).not_to have_content("#{discount_1.qty_threshold}")
    end
  end
end