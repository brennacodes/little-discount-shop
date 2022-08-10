require 'rails_helper'

RSpec.describe 'merchant dashboard', type: :feature do
  let!(:merchant_1) { Merchant.create!(name: 'Micheal Jordan') }
  let!(:merchant_2) { Merchant.create!(name: 'John Doe') }
  let!(:item_1) { Item.create!(name: 'Item 1', description: 'Description 1', unit_price: 100, merchant_id: merchant_1.id, status: 0) }
  let!(:item_2) { Item.create!(name: 'Item 2', description: 'Description 2', unit_price: 200, merchant_id: merchant_1.id, status: 0) }
  let!(:item_3) { Item.create!(name: 'Item 3', description: 'Description 3', unit_price: 300, merchant_id: merchant_1.id, status: 0) }
  let!(:item_4) { Item.create!(name: 'Item 4', description: 'Description 4', unit_price: 400, merchant_id: merchant_2.id, status: 0) }
  let!(:item_5) { Item.create!(name: 'Item 5', description: 'Description 5', unit_price: 500, merchant_id: merchant_2.id, status: 1) }
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

  before(:each) do
    visit "/merchants/#{merchant_1.id}/dashboard"
  end

  it 'shows merchant name' do
    expect(page).to have_content(merchant_1.name)
    expect(page).not_to have_content(merchant_2.name)
  end

  describe 'links' do
    it 'has a link to merchant items index' do
      expect(page).to have_link('Items')

      click_on 'Items', match: :first

      expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
    end

    it 'has a link to merchant invoices index' do
      expect(page).to have_link('Invoices')

      click_on 'Invoices', match: :first

      expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices")
    end

    it 'has a link to view all merchant discounts' do
      expect(page).to have_link('Discounts')

      click_on 'Discounts', match: :first

      expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts")
    end

  end

  describe 'statistics' do
    it 'shows a list of the top 5 customers by total number of successful transactions' do
      expect(page).to have_content('Top 5 Customers')

      top_5 = [nicole, andre, lucy, greg]

      # expect(merchant_1.top_5_customers.count).to eq(5)
      expect(merchant_1.top_5_customers).to eq(top_5)

      within '#top-5-customers' do
        expect(page).to have_content("#{andre.full_name} Successful Transactions: 2")
        expect(page).to have_content("#{nicole.full_name} Successful Transactions: 2")
        expect(page).to have_content("#{greg.full_name} Successful Transactions: 1")
        expect(page).to have_content("#{lucy.full_name} Successful Transactions: 1")

        expect(page).not_to have_content(brenna.full_name)
      end
    end
  end

  describe 'items' do
    it 'shows a list of items ready to ship' do
      expect(page).to have_content('Items Ready to Ship')

      expect(merchant_1.ready_to_ship.count).to eq(6)

      ready_to_ship = [item_3, item_2, item_1]

      expect(merchant_1.items_ready_to_ship).to eq(ready_to_ship)

      within '#items-ready-to-ship' do
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(item_3.name)
        expect(page).not_to have_content(item_4.name)
      end
    end

    it 'links to each items show page' do
      within "#items-ready-to-ship" do
        expect(page).to have_link(item_1.name)
        expect(page).to have_link(item_2.name)
        expect(page).to have_link(item_3.name)

        click_on item_1.name, match: :first

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item_1.id}")
      end
    end

    it 'links to each invoice id' do
      within "##{invoice_item_1.id}-#{invoice_item_1.invoice_id}-id" do
        expect(page).to have_link("#{invoice_1.id}")

        click_on "#{invoice_1.id}"

        expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices/#{invoice_item_1.invoice_id}")
      end
    end

    it 'formats the invoice creation date' do
      date = Time.now
      formatted = date.strftime("%A, %B %d, %Y")

      within "##{invoice_item_1.id}-#{invoice_item_1.invoice_id}-date" do
        expect(page).to have_content(invoice_item_1.created_at.strftime("%A, %B %d, %Y"))
      end
    end

    it 'displays the invoice items name' do
      within "##{invoice_item_1.id}-#{invoice_item_1.invoice_id}-name" do
        expect(page).to have_content(invoice_item_1.item.name)
      end
    end

    it 'displays the invoice items quantity' do
      within "##{invoice_item_1.id}-#{invoice_item_1.invoice_id}-qty" do
        expect(page).to have_content(invoice_item_1.quantity)
      end
    end

    it 'displays the invoice items unit price' do
      within "##{invoice_item_1.id}-#{invoice_item_1.invoice_id}-price" do
        price = invoice_item_1.unit_price.to_f / 100

        expect(page).to have_content(price)
      end
    end
  end
end

# When I visit my merchant dashboard
# Then I see a link to view all my discounts
# When I click this link
# Then I am taken to my bulk discounts index page
# Where I see all of my bulk discounts including their
# percentage discount and quantity thresholds
# And each bulk discount listed includes a link to its show page