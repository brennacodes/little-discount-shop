require 'rails_helper'

RSpec.describe Merchant, type: :model do
  let!(:merchant_1) { Merchant.create!(name: 'Micheal Jordan', status: 0) }
  let!(:merchant_2) { Merchant.create!(name: 'Larry Jordan', status: 0) }
  let!(:merchant_3) { Merchant.create!(name: 'Barry Jordan', status: 0) }
  let!(:merchant_4) { Merchant.create!(name: 'Kimmy Koppelman', status: 0) }
  let!(:merchant_5) { Merchant.create!(name: 'Patty Pancakes', status: 0) }

  let!(:item_1) { Item.create!(name: 'Item 1', description: 'Description 1', unit_price: 100, merchant_id: merchant_1.id, status: 0) }
  let!(:item_2) { Item.create!(name: 'Item 2', description: 'Description 2', unit_price: 200, merchant_id: merchant_1.id, status: 1) }
  let!(:item_3) { Item.create!(name: 'Item 3', description: 'Description 3', unit_price: 300, merchant_id: merchant_1.id, status: 1) }
  let!(:item_4) { Item.create!(name: 'Item 4', description: 'Description 4', unit_price: 400, merchant_id: merchant_2.id, status: 1) }
  let!(:item_5) { Item.create!(name: 'Item 5', description: 'Description 5', unit_price: 500, merchant_id: merchant_3.id, status: 1) }
  let!(:item_6) { Item.create!(name: 'Item 6', description: 'Description 6', unit_price: 600, merchant_id: merchant_4.id, status: 1) }
  let!(:item_7) { Item.create!(name: 'Item 7', description: 'Description 7', unit_price: 700, merchant_id: merchant_5.id, status: 1) }
  let!(:item_8) { Item.create!(name: 'Item 8', description: 'Description 8', unit_price: 800, merchant_id: merchant_5.id, status: 1) }
  let!(:item_9) { Item.create!(name: 'Item 9', description: 'Description 9', unit_price: 900, merchant_id: merchant_5.id, status: 1) }

  let!(:customer) { Customer.create!(first_name: 'John', last_name: 'Doe') }
  let!(:customer_1) { Customer.create!(first_name: 'Susan', last_name: 'Doe') }
  let!(:customer_2) { Customer.create!(first_name: 'Larry', last_name: 'Doe') }
  let!(:customer_3) { Customer.create!(first_name: 'Barbara', last_name: 'Doe') }
  let!(:customer_4) { Customer.create!(first_name: 'Patrick', last_name: 'Doe') }
  let!(:customer_5) { Customer.create!(first_name: 'Mira', last_name: 'Doe') }

  let!(:invoice) { Invoice.create!(customer_id: customer.id, status: 0) }
  let!(:invoice_1) { Invoice.create!(customer_id: customer.id, status: 0) }
  let!(:invoice_2) { Invoice.create!(customer_id: customer.id, status: 0) }
  let!(:invoice_3) { Invoice.create!(customer_id: customer_1.id, status: 0) }
  let!(:invoice_4) { Invoice.create!(customer_id: customer_1.id, status: 0) }
  let!(:invoice_5) { Invoice.create!(customer_id: customer_2.id, status: 0) }
  let!(:invoice_6) { Invoice.create!(customer_id: customer_2.id, status: 0) }
  let!(:invoice_7) { Invoice.create!(customer_id: customer_3.id, status: 0) }
  let!(:invoice_8) { Invoice.create!(customer_id: customer_4.id, status: 0) }

  let!(:transaction) { Transaction.create!(result: 0, credit_card_number: '09824570298208752', invoice_id: invoice.id) }
  let!(:transaction_1) { Transaction.create!(result: 0, credit_card_number: '09824570298208752', invoice_id: invoice_1.id) }
  let!(:transaction_2) { Transaction.create!(result: 0, credit_card_number: '09824570298208752', invoice_id: invoice_2.id) }
  let!(:transaction_3) { Transaction.create!(result: 0, credit_card_number: '09824570298208752', invoice_id: invoice_3.id) }
  let!(:transaction_4) { Transaction.create!(result: 0, credit_card_number: '09824570298208752', invoice_id: invoice_4.id) }
  let!(:transaction_5) { Transaction.create!(result: 0, credit_card_number: '09824570298208752', invoice_id: invoice_5.id) }
  let!(:transaction_6) { Transaction.create!(result: 0, credit_card_number: '09824570298208752', invoice_id: invoice_6.id) }
  let!(:transaction_7) { Transaction.create!(result: 0, credit_card_number: '09824570298208752', invoice_id: invoice_7.id) }
  let!(:transaction_8) { Transaction.create!(result: 0, credit_card_number: '09824570298208752', invoice_id: invoice_8.id) }

  let!(:invoice_item_1) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice.id, quantity: 1, unit_price: 100, status: 0) }
  let!(:invoice_item_2) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice.id, quantity: 2, unit_price: 200, status: 0) }
  let!(:invoice_item_3) { InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_8.id, quantity: 3, unit_price: 300, status: 0) }
  let!(:invoice_item_4) { InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_7.id, quantity: 4, unit_price: 400, status: 0) }
  let!(:invoice_item_5) { InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_6.id, quantity: 5, unit_price: 500, status: 0) }
  let!(:invoice_item_6) { InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_1.id, quantity: 6, unit_price: 100, status: 1) }
  let!(:invoice_item_7) { InvoiceItem.create!(item_id: item_7.id, invoice_id: invoice_2.id, quantity: 7, unit_price: 200, status: 1) }
  let!(:invoice_item_8) { InvoiceItem.create!(item_id: item_8.id, invoice_id: invoice_3.id, quantity: 8, unit_price: 300, status: 1) }
  let!(:invoice_item_9) { InvoiceItem.create!(item_id: item_9.id, invoice_id: invoice_4.id, quantity: 9, unit_price: 400, status: 1) }
  let!(:invoice_item_10) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 10, unit_price: 500, status: 2) }
  let!(:invoice_item_11) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 11, unit_price: 600, status: 2) }
  let!(:invoice_item_12) { InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 12, unit_price: 700, status: 2) }
  let!(:invoice_item_13) { InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, quantity: 13, unit_price: 800, status: 2) }
  let!(:invoice_item_14) { InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, quantity: 14, unit_price: 900, status: 2) }
  let!(:invoice_item_15) { InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, quantity: 15, unit_price: 1000, status: 2) }
  let!(:invoice_item_16) { InvoiceItem.create!(item_id: item_7.id, invoice_id: invoice_7.id, quantity: 16, unit_price: 100, status: 2) }
  let!(:invoice_item_17) { InvoiceItem.create!(item_id: item_8.id, invoice_id: invoice_8.id, quantity: 17, unit_price: 200, status: 2) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:discounts) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { is_expected.to define_enum_for(:status).with_values([:disabled, :enabled]) }
  end

  describe 'scopes' do
    it 'returns all disabled merchants' do
      expect(Merchant.disabled_merchants).to eq([merchant_1, merchant_2, merchant_3, merchant_4, merchant_5])
    end

    it 'returns all enabled merchants' do
      merchant_4 = Merchant.create!(name: 'Merchant 4', status: 1)
      merchant_5 = Merchant.create!(name: 'Merchant 5', status: 1)
      merchant_6 = Merchant.create!(name: 'Merchant 6', status: 1)

      expect(Merchant.enabled_merchants).to eq([merchant_4, merchant_5, merchant_6])
    end
  end

  describe 'class methods' do
    it 'returns the top 5 merchants ranked by total revenue' do
      top_5 = Merchant.top_5_merchants
      
      expect(top_5).to eq([merchant_1, merchant_4, merchant_3, merchant_5, merchant_2])
    end

    it 'can find all merchants with status of enabled' do
      merchant_6 = Merchant.create!(name: 'Kelly Jordan', status: 0)
      merchant_7 = Merchant.create!(name: 'Wallys World', status: 1)
      merchant_8 = Merchant.create!(name: 'Vendorific', status: 1)
      
      expect(Merchant.enabled_merchants).to eq([merchant_7, merchant_8])
    end
    
    it 'can find all merchants with status of disabled' do
      merchant_6 = Merchant.create!(name: 'Kelly Jordan', status: 0)
      merchant_7 = Merchant.create!(name: 'Wallys World', status: 1)
      merchant_8 = Merchant.create!(name: 'Vendorific', status: 1)

      expect(Merchant.disabled_merchants).to eq([merchant_1, merchant_2, merchant_3, merchant_4, merchant_5, merchant_6])
    end

    it 'can find a merchant by user input' do
      expect(Merchant.find_by_input("Michael")).to eq(merchant_1)
      expect(Merchant.find_by_input("Jordan")).to eq(merchant_3, merchant_2, merchant_1)
      expect(Merchant.find_by_input("Jor")).to eq(merchant_3, merchant_2, merchant_1)
    end

    it 'can find all matching merchants by user input' do
      expect(Merchant.find_all_by_input("Jordan")).to eq([merchant_3, merchant_2, merchant_1])
    end
  end

  describe 'instance methods' do
    it 'returns the best day for a merchants sales' do
      expect(merchant_1.top_day.strftime("%Y-%m-%d")).to eq(invoice_1.created_at.strftime("%Y-%m-%d"))
    end

    it 'can find top 5 customers with most successful transactions' do
      top_5 = merchant_1.top_5_customers.uniq

      expect(top_5).to eq([customer, customer_1, customer_4])
    end

    it 'can find top 5 items with the most revenue' do
      top_5 = merchant_1.top_5_items.map { |item| item }

      expect(top_5).to eq([item_3, item_2, item_1])
    end

    it 'can find all items ready to ship' do
      expect(merchant_1.items_ready_to_ship).to eq([item_3, item_2, item_1])
    end

    it 'can return all discounts that belong to the merchant' do
      discount_1 = Discount.create!(merchant_id: merchant_1.id, name: '33% off', percent: 33, qty_threshold: 11)
      discount_2 = Discount.create!(merchant_id: merchant_1.id, name: '44% off', percent: 44, qty_threshold: 22)
      discount_3 = Discount.create!(merchant_id: merchant_2.id, name: '55% off', percent: 55, qty_threshold: 33)

      expect(merchant_1.merchants_discounts).to eq([discount_1, discount_2])
    end

    it 'can find all of a merchants items' do
      expect(merchant_1.merchants_items).to eq([item_1, item_2, item_3])
    end

    it 'can find all of a merchants invoices' do
      invoices = merchant_1.merchants_invoices

      expect(invoices).to eq([invoice, invoice_1, invoice_2, invoice_3, invoice_8])
    end

    it 'can return all of a merchants enabled items' do
      expect(merchant_1.enabled_items).to eq([item_2, item_3])
    end

    it 'can return all of a merchants disabled items' do
      expect(merchant_1.disabled_items).to eq([item_1])
    end
  end
end
