require 'rails_helper'

RSpec.describe 'merchant discount edit page', type: :feature do
  let!(:merchant) { Merchant.create!(name: 'Merchant 1') }
  let!(:item_1) { merchant.items.create!(name: 'Item 1', description: 'Item 1 description', unit_price: '100') }
  let!(:customer) { Customer.create!(first_name: 'John', last_name: 'Doe') }
  let!(:invoice) { Invoice.create!(customer_id: customer.id, status: 1) }
  let!(:invoice_2) { Invoice.create!(customer_id: customer.id, status: 1) }
  let!(:invoice_item_1) { InvoiceItem.create!(invoice_id: invoice.id, item_id: item_1.id, quantity: 10, unit_price: 100, status: 2) }
  let!(:invoice_item_2) { InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_1.id, quantity: 10, unit_price: 100, status: 0) }
  let!(:discount) { Discount.create!(merchant_id: merchant.id, name: 'Sale sale sale!', percent: 77, qty_threshold: 8, holiday_date: "2022-09-05") }
  let!(:discount_1) { Discount.create!(merchant_id: merchant.id, name: 'New Savings!', percent: 33, qty_threshold: 3, holiday_date: "2023-09-23") }
  let!(:discount_2) { Discount.create!(merchant_id: merchant.id, name: 'Christmas!', percent: 22, qty_threshold: 22, holiday_date: "2023-09-23") }
  let!(:discount_invoice_item) { DiscountInvoiceItem.create!(invoice_item_id: invoice_item_1.id, discount_id: discount.id) }
  let!(:discount_invoice_item_1) { DiscountInvoiceItem.create!(invoice_item_id: invoice_item_2.id, discount_id: discount_1.id) }

  before do
    visit "/merchants/#{merchant.id}/discounts/#{discount.id}"
  end

  describe 'form' do
    it 'prepopulates with discount info' do
      click_on "Edit Bulk Discount"

      expect(find_field('Name').value).to eq("#{discount.name}")
      expect(find_field('Percent').value).to eq("#{discount.percent.to_s}")
      expect(find_field('discount[qty_threshold]').value).to eq("#{discount.qty_threshold.to_s}")
    end

    it 'updates discount info' do
      expect(discount.has_pending_invoices?).to eq(false)
      expect(Discount.discount_conflicts?(discount)).to eq(false)

      click_on "Edit Bulk Discount"

      fill_in 'Name', with: 'a;lskdjf;aldk'
      fill_in 'Percent', with: '99'
      fill_in 'discount[qty_threshold]', with: '66'

      click_on 'Submit'

      expect(current_path).to eq("/merchants/#{merchant.id}/discounts/#{discount.id}")
      expect(page).to have_content('a;lskdjf;aldk')
      expect(page).to have_content('99%')
      expect(page).to have_content('66')
    end
  end

  describe 'conditions' do
    it 'cannot edit a bulk discount if there is a preexisting discount that would cause conflicts' do
      visit edit_merchant_discount_path(merchant, discount)
      
      expect(find_field('Name').value).to eq(discount.name)
      expect(find_field('Percent').value).to eq(discount.percent.to_s)
      expect(find_field('discount[qty_threshold]').value).to eq(discount.qty_threshold.to_s)

      fill_in 'Name', with: 'Christmas!'
      fill_in 'Percent', with: '22'
      fill_in 'discount[qty_threshold]', with: '22'

      click_on 'Submit'
      
      expect(page).to have_content("Discount could not be updated. There may be an existing discount that would conflict, or the discount may have pending invoices. Please check your inputs and try again.")
      expect(current_path).to eq("/merchants/#{merchant.id}/discounts/#{discount.id}/edit")
    end

    it 'cannot edit a bulk discount if it has pending invoices' do
      visit merchant_discounts_path(merchant)

      within "##{discount.id}-percent" do
        expect(page).to have_content("#{discount.percent}%")
      end

      within "##{discount.id}-qty" do
        expect(page).to have_content(discount.qty_threshold)
      end

      within "##{discount.id}-view" do
        click_on "View Discount"
      end

      expect(current_path).to eq("/merchants/#{merchant.id}/discounts/#{discount.id}")

      expect(page).to have_content(discount.name)
      expect(page).to have_content(discount.percent)
      expect(page).to have_content(discount.qty_threshold)

      expect(page).to have_link('Edit Bulk Discount')

      visit "/merchants/#{merchant.id}/discounts"

      within "##{discount_1.id}-percent" do
        expect(page).to have_content("#{discount_1.percent}%")
      end

      within "##{discount_1.id}-qty" do
        expect(page).to have_content(discount_1.qty_threshold)
      end

      within "##{discount_1.id}-view" do
        click_on "View Discount"
      end

        expect(current_path).to eq("/merchants/#{merchant.id}/discounts/#{discount_1.id}")
        expect(page).to have_content(discount_1.name)
        expect(page).to have_content(discount_1.percent)
        expect(page).to have_content(discount_1.qty_threshold)

        expect(page).not_to have_link('Edit Bulk Discount')
    end
  end
end