require 'rails_helper'

RSpec.describe 'merchant items index page', type: :feature do
  let!(:merchant_1) { Merchant.create!(name: 'Micheal Jordan') }
  let!(:merchant_2) { Merchant.create!(name: 'John Doe') }
  let!(:item_1) { Item.create!(name: 'Item 1', description: 'Description 1', unit_price: 100, merchant_id: merchant_1.id, status: 0) }
  let!(:item_2) { Item.create!(name: 'Item 2', description: 'Description 2', unit_price: 200, merchant_id: merchant_1.id, status: 0) }
  let!(:item_3) { Item.create!(name: 'Item 3', description: 'Description 3', unit_price: 300, merchant_id: merchant_1.id, status: 0) }
  let!(:item_4) { Item.create!(name: 'Item 4', description: 'Description 4', unit_price: 400, merchant_id: merchant_1.id, status: 0) }
  let!(:item_4) { Item.create!(name: 'Item 4', description: 'Description 4', unit_price: 400, merchant_id: merchant_2.id, status: 0) }
  let!(:item_5) { Item.create!(name: 'Item 5', description: 'Description 5', unit_price: 500, merchant_id: merchant_1.id, status: 0) }
  let!(:item_5) { Item.create!(name: 'Item 5', description: 'Description 5', unit_price: 500, merchant_id: merchant_2.id, status: 1) }
  let!(:item_6) { Item.create!(name: 'Item 6', description: 'Description 6', unit_price: 600, merchant_id: merchant_1.id, status: 0) }
  let!(:item_7) { Item.create!(name: 'Item 7', description: 'Description 7', unit_price: 700, merchant_id: merchant_1.id, status: 0) }
  let!(:nicole) { Customer.create!(first_name: 'Nicole', last_name: 'Smith') }
  let!(:andre) { Customer.create!(first_name: 'Andre', last_name: 'Sandre') }
  let!(:brenna) { Customer.create!(first_name: 'Brenna', last_name: 'Bobenna') }
  let!(:greg) { Customer.create!(first_name: 'Greg', last_name: 'Gory') }
  let!(:lucy) { Customer.create!(first_name: 'Lucy', last_name: 'Diamond') }
  let!(:mildred) { Customer.create!(first_name: 'Mildred', last_name: 'Von Mildenburg') }
  let!(:invoice_1) { Invoice.create!(customer_id: nicole.id, status: 0) }
  let!(:invoice_2) { Invoice.create!(customer_id: andre.id, status: 1) }
  let!(:invoice_3) { Invoice.create!(customer_id: brenna.id, status: 2) }
  let!(:invoice_4) { Invoice.create!(customer_id: greg.id, status: 0) }
  let!(:invoice_5) { Invoice.create!(customer_id: lucy.id, status: 1) }
  let!(:invoice_6) { Invoice.create!(customer_id: mildred.id, status: 2) }
  let!(:invoice1_transaction_1) { invoice_1.transactions.create!(result: 0, credit_card_number: 1234567890123456, credit_card_expiration_date: nil) }
  let!(:invoice1_transaction_2) { invoice_1.transactions.create!(result: 1, credit_card_number: 1234567890987653, credit_card_expiration_date: nil) }
  let!(:invoice1_transaction_3) { invoice_1.transactions.create!(result: 0, credit_card_number: 1234567890987654, credit_card_expiration_date: nil) }
  let!(:invoice2_transaction_1) { invoice_2.transactions.create!(result: 0, credit_card_number: 1234567897778889, credit_card_expiration_date: nil) }
  let!(:invoice2_transaction_2) { invoice_2.transactions.create!(result: 1, credit_card_number: 1234567890999777, credit_card_expiration_date: nil) }
  let!(:invoice3_transaction_1) { invoice_2.transactions.create!(result: 0, credit_card_number: 1234567890191919, credit_card_expiration_date: nil) }
  let!(:invoice4_transaction_1) { invoice_3.transactions.create!(result: 0, credit_card_number: 1234567890123456, credit_card_expiration_date: nil) }
  let!(:invoice3_transaction_2) { invoice_3.transactions.create!(result: 1, credit_card_number: 1234567890981000, credit_card_expiration_date: nil) }
  let!(:invoice4_transaction_2) { invoice_3.transactions.create!(result: 0, credit_card_number: 1234567890987653, credit_card_expiration_date: nil) }
  let!(:invoice4_transaction_1) { invoice_4.transactions.create!(result: 0, credit_card_number: 1234567897133322, credit_card_expiration_date: nil) }
  let!(:invoice4_transaction_2) { invoice_4.transactions.create!(result: 1, credit_card_number: 1234567890955555, credit_card_expiration_date: nil) }
  let!(:invoice5_transaction_1) { invoice_5.transactions.create!(result: 0, credit_card_number: 1234567890111111, credit_card_expiration_date: nil) }
  let!(:invoice5_transaction_2) { invoice_5.transactions.create!(result: 1, credit_card_number: 1234567890987654, credit_card_expiration_date: nil) }
  let!(:invoice6_transaction_1) { invoice_6.transactions.create!(result: 1, credit_card_number: 1234567890111111, credit_card_expiration_date: nil) }
  let!(:invoice6_transaction_2) { invoice_6.transactions.create!(result: 1, credit_card_number: 1234567890987654, credit_card_expiration_date: nil) }
  let!(:invoice_item_1) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 0) }
  let!(:invoice_item_2) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 2, unit_price: item_2.unit_price, status: 0) }
  let!(:invoice_item_3) { InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_2.id, quantity: 3, unit_price: item_3.unit_price, status: 1) }
  let!(:invoice_item_4) { InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_2.id, quantity: 4, unit_price: item_4.unit_price, status: 1) }
  let!(:invoice_item_5) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_3.id, quantity: 5, unit_price: item_1.unit_price, status: 2) }
  let!(:invoice_item_6) { InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 6, unit_price: item_2.unit_price, status: 2) }
  let!(:invoice_item_7) { InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, quantity: 7, unit_price: item_4.unit_price, status: 0) }
  let!(:invoice_item_8) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_4.id, quantity: 8, unit_price: item_1.unit_price, status: 0) }
  let!(:invoice_item_9) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_5.id, quantity: 9, unit_price: item_2.unit_price, status: 1) }
  let!(:invoice_item_10) { InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_5.id, quantity: 10, unit_price: item_3.unit_price, status: 1) }
  let!(:invoice_item_11) { InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_6.id, quantity: 11, unit_price: item_4.unit_price, status: 2) }
  let!(:invoice_item_12) { InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_6.id, quantity: 12, unit_price: item_1.unit_price, status: 2) }
  let!(:invoice_item_13) { InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_1.id, quantity: 13, unit_price: item_6.unit_price, status: 1) }
  let!(:invoice_item_14) { InvoiceItem.create!(item_id: item_7.id, invoice_id: invoice_1.id, quantity: 14, unit_price: item_7.unit_price, status: 1) }

  before(:each) do
    visit "/merchants/#{merchant_1.id}/items"
  end

  describe 'links' do
    it 'has a link to create a new item' do
      expect(page).to have_link('Create New Item')

      click_on 'Create New Item', match: :first

      expect(current_path).to eq("/merchants/#{merchant_1.id}/items/new")
    end

    it 'to each items show page via each items name' do
      within '#items-ready-to-ship' do
        expect(page).to have_link(item_1.name)
        expect(page).to have_link(item_2.name)
        expect(page).to have_link(item_3.name)
        expect(page).not_to have_link(item_4.name)

        click_on item_1.name, match: :first

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item_1.id}")
      end
    end
  end

  describe 'statistics' do
    it 'shows a list of the top 5 items by total revenue generated' do
      expect(page).to have_content('Top 5 Items')

      top_5 = merchant_1.top_5_items.map {|item| item }

      expect(top_5).to eq([item_7, item_6, item_3, item_2, item_1])

      within '#top-5-items' do
        expect(page).to have_content(item_7.name)
        expect(page).to have_content(item_6.name)
        expect(page).to have_content(item_3.name)
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(item_1.name)
      end
    end

    it 'shows the revenue generated by each item' do
      expect(page).to have_content('Revenue Generated')

      within "#item-#{item_1.id}-revenue" do
        expect(page).to have_content("42.0")
      end
    end

    it 'links to each items show page via each items name' do
      within '#top-5-items' do
        within "#top-item-#{item_3.id}" do
          expect(page).to have_link(item_3.name)
        end
      end

      within "#top-item-#{item_3.id}" do
        click_on item_3.name
      end

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item_3.id}")
    end

    it 'shows each items best date by number of sales' do
      within '#top-5-items' do
        expect(page).to have_content('Top Selling Day for Was:')
      end
    end
  end

  describe 'data' do
    it 'has a section for enabled and disabled items' do
      expect(page).to have_content('Enabled Items')
      expect(page).to have_content('Disabled Items')
    end

    it 'puts items in the correct section' do
      within '#enabled-items' do
        expect(page).not_to have_content(item_1.name)
        expect(page).not_to have_content(item_2.name)
        expect(page).not_to have_content(item_3.name)
      end
      
      within '#disabled-items' do
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(item_3.name)
        expect(page).to have_content(item_6.name)
        expect(page).to have_content(item_7.name)
      end
    end
    
    it 'has a button to enable and disable items' do
      within '#disabled-items' do
        expect(page).to have_content(item_1.name)
        expect(page).to have_button('Enable')

        click_on 'Enable', match: :first

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items")

        expect(page).not_to have_content(item_1.name)
      end

      within '#enabled-items' do
        expect(page).to have_button('Disable')

        click_on 'Disable', match: :first

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items")

        expect(page).not_to have_content(item_1.name)
      end
    end
  end
end