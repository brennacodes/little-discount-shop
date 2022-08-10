require 'rails_helper'

RSpec.describe 'admin merchants index page', type: :feature do
  let!(:merchant_1) { Merchant.create!(name: "The Gibson Project") }
  let!(:merchant_2) { Merchant.create!(name: "The Larry Project") }
  let!(:merchant_3) { Merchant.create!(name: "The Jeff Project") }
  let!(:merchant_4) { Merchant.create!(name: "The Bill Project") }
  let!(:merchant_5) { Merchant.create!(name: "The Jim Project") }
  let!(:merchant_6) { Merchant.create!(name: "The Tom Project", status: 1) }
  let!(:merchant_7) { Merchant.create!(name: "The Jack Project", status: 1) }

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
  let!(:item_3) { Item.create!(name: "Item 3", description: "Description 3", unit_price: 300, merchant_id: merchant_2.id) }
  let!(:item_4) { Item.create!(name: "Item 4", description: "Description 4", unit_price: 400, merchant_id: merchant_2.id) }
  let!(:item_5) { Item.create!(name: "Item 5", description: "Description 5", unit_price: 500, merchant_id: merchant_3.id) }
  let!(:item_6) { Item.create!(name: "Item 6", description: "Description 6", unit_price: 600, merchant_id: merchant_4.id) }
  let!(:item_7) { Item.create!(name: "Item 7", description: "Description 7", unit_price: 700, merchant_id: merchant_5.id) }
  let!(:item_8) { Item.create!(name: "Item 8", description: "Description 8", unit_price: 800, merchant_id: merchant_6.id) }
  let!(:item_9) { Item.create!(name: "Item 9", description: "Description 9", unit_price: 900, merchant_id: merchant_7.id) }

  let!(:invoice_item_1) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 100, status: 0) }
  let!(:invoice_item_2) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 200, status: 0) }
  let!(:invoice_item_3) { InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_2.id, quantity: 1, unit_price: 300, status: 1) }
  let!(:invoice_item_4) { InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_2.id, quantity: 1, unit_price: 400, status: 1) }
  let!(:invoice_item_5) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_3.id, quantity: 1, unit_price: 100, status: 2) }
  let!(:invoice_item_6) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_3.id, quantity: 1, unit_price: 200, status: 2) }
  let!(:invoice_item_7) { InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_4.id, quantity: 1, unit_price: 300, status: 2) }
  let!(:invoice_item_8) { InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, quantity: 1, unit_price: 400, status: 2) }
  let!(:invoice_item_9) { InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, quantity: 1, unit_price: 500, status: 2) }
  let!(:invoice_item_10) { InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, quantity: 1, unit_price: 600, status: 2) }
  let!(:invoice_item_11) { InvoiceItem.create!(item_id: item_7.id, invoice_id: invoice_7.id, quantity: 1, unit_price: 700, status: 2) }
  let!(:invoice_item_12) { InvoiceItem.create!(item_id: item_8.id, invoice_id: invoice_8.id, quantity: 1, unit_price: 800, status: 2) }
  let!(:invoice_item_13) { InvoiceItem.create!(item_id: item_9.id, invoice_id: invoice_9.id, quantity: 1, unit_price: 900, status: 2) }
  let!(:invoice_item_14) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_10.id, quantity: 1, unit_price: 100, status: 2) }
  let!(:invoice_item_15) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_10.id, quantity: 1, unit_price: 200, status: 2) }

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
    visit "/admin/merchants"
  end

  describe 'creates a new merchant' do
    it 'has a link to create a new merchant' do
      expect(page).to have_link("Create New Merchant")
    end

    it 'redirects back to index page after creation' do
      click_link "Create New Merchant"

      fill_in "Name", with: "Madrigol's Merchant"
      
      click_on "Submit"

      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_content("Madrigol's Merchant")
    end
  end

  it 'has the name of each merchant in the system' do
    expect(page).to have_content("#{merchant_1.name}")
    expect(page).to have_content("#{merchant_2.name}")
    expect(page).to have_content("#{merchant_3.name}")
    expect(page).to have_content("#{merchant_4.name}")
    expect(page).to have_content("#{merchant_5.name}")
  end

  it 'has buttons to disable or enable the merchant' do
    expect(page).to have_button("Enable")

    click_button "Enable", match: :first

    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_button("Disable")
  end

  it 'has two separate sections for enabled and disabled merchants' do
    within "#disabled-merchants" do
      expect(page).to have_content("#{merchant_1.name}")
      expect(page).to have_content("#{merchant_2.name}")

      click_button "Enable", match: :first

      expect(current_path).to eq("/admin/merchants")
      expect(page).not_to have_content("#{merchant_1.name}")
    end

    within "#enabled-merchants" do
      expect(page).to have_content("#{merchant_1.name}")
    end
  end

  it 'displays top 5 merchants based on revenue generated' do
    expect(page).to have_content("Top 5 Merchants by Generated Revenue:")

    within "#top_5_merchants" do
      expect(page).to have_content("#{merchant_1.name}")
      expect(page).to have_content("#{merchant_2.name}")
      expect(page).to have_content("#{merchant_7.name}")
      expect(page).to have_content("#{merchant_6.name}")
      expect(page).to have_content("#{merchant_5.name}")
    end

    expect(merchant_1.name).to appear_before(merchant_2.name)
    expect(merchant_2.name).to appear_before(merchant_7.name)
    expect(merchant_7.name).to appear_before(merchant_6.name)
    expect(merchant_6.name).to appear_before(merchant_5.name)
  end
end
