require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:merchant_id) }
    it {is_expected.to define_enum_for(:status).with_values(['disabled', 'enabled'])}
  end

  describe 'relationships' do 
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'class methods' do
    it 'can find all items with status of enabled' do
      merchant = Merchant.create!(name: 'Micheal Jordan')
      item_1 = Item.create!(name: 'Item 1', description: 'Description 1', unit_price: 100, merchant_id: merchant.id, status: 0)
      item_2 = Item.create!(name: 'Item 2', description: 'Description 2', unit_price: 200, merchant_id: merchant.id, status: 1)
      item_3 = Item.create!(name: 'Item 3', description: 'Description 3', unit_price: 300, merchant_id: merchant.id, status: 1)

      expect(Item.enabled_items(merchant.id)).to eq([item_2, item_3])
    end

    it 'can find all items with status of disabled' do
      merchant = Merchant.create!(name: 'Micheal Jordan')
      item_1 = Item.create!(name: 'Item 1', description: 'Description 1', unit_price: 100, merchant_id: merchant.id, status: 0)
      item_2 = Item.create!(name: 'Item 2', description: 'Description 2', unit_price: 200, merchant_id: merchant.id, status: 1)
      item_3 = Item.create!(name: 'Item 3', description: 'Description 3', unit_price: 300, merchant_id: merchant.id, status: 1)

      expect(Item.disabled_items(merchant.id)).to eq([item_1])
    end
  end

  describe 'instance methods' do    
    it 'can list all statuses' do
      merchant = Merchant.create!(name: 'Micheal Jordan')
      item_1 = Item.create!(name: 'Item 1', description: 'Description 1', unit_price: 100, merchant_id: merchant.id, status: 0)
      expect(item_1.status_options).to eq(['disabled', 'enabled'])
    end

    it 'can find the top day for an item' do
      merchant = Merchant.create!(name: 'Micheal Jordan')
      item_1 = Item.create!(name: 'Item 1', description: 'Description 1', unit_price: 100, merchant_id: merchant.id, status: 0)
      customer = Customer.create!(first_name: 'John', last_name: 'Doe')
      invoice = Invoice.create!(customer_id: customer.id, status: 0)
      invoice_item = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice.id, quantity: 1, unit_price: 100, status: 0)

      expect(item_1.top_day).to eq(invoice.created_at)
    end
  end      
end
  
