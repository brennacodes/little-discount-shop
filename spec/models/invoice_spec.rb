require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let!(:merchant_a) { Merchant.create!(name: "Merchant A") }
  let!(:merchant_b) { Merchant.create!(name: "Merchant B") }
  let!(:customer) { Customer.create!(first_name: "John", last_name: "Doe") }
  let!(:invoice_a) { Invoice.create!(customer_id: customer.id, status: 1) }
  let!(:invoice_b) { Invoice.create!(customer_id: customer.id, status: 1) }
  let!(:item_a) { Item.create!(name: "Item A", description: "Item A description", unit_price: 100, merchant_id: merchant_a.id) }
  let!(:item_b) { Item.create!(name: "Item B", description: "Item B description", unit_price: 200, merchant_id: merchant_a.id) }

  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:discounts).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of (:status) }
    it { should validate_presence_of (:customer_id) }
    it {is_expected.to define_enum_for(:status).with_values(['cancelled', 'in progress', 'completed'])}
  end

  describe 'class methods' do
    it 'can return all status options' do
      expect(Invoice.status_options).to eq(['cancelled', 'in progress', 'completed'])
    end

    it 'can filter out all invoices with status of cancelled' do 
      sally = Customer.create!(first_name: "Sally", last_name: "Sunshine")
      invoice_1 = sally.invoices.create!(status: 1)
      invoice_2 = sally.invoices.create!(status: 1)
      invoice_3 = sally.invoices.create!(status: 0)

      expect(Invoice.not_cancelled).to eq([invoice_a, invoice_b, invoice_1, invoice_2])
    end

    it 'can return all incomplete invoices' do
      invoice_item_1 = InvoiceItem.create!(item_id: item_a.id, invoice_id: invoice_a.id, quantity: 1, unit_price: 100, status: 0)
      invoice_item_2 = InvoiceItem.create!(item_id: item_b.id, invoice_id: invoice_a.id, quantity: 1, unit_price: 200, status: 0)
      invoice_item_3 = InvoiceItem.create!(item_id: item_a.id, invoice_id: invoice_b.id, quantity: 1, unit_price: 100, status: 2)
      invoice_item_4 = InvoiceItem.create!(item_id: item_b.id, invoice_id: invoice_b.id, quantity: 1, unit_price: 200, status: 2)

      expect(Invoice.incomplete_invoices.first).to eq(invoice_a)
    end
   end

  describe 'instance methods' do
    it 'can calculate the total revenue' do
      merchant = Merchant.create!(name: "Bob's Burgers")
      sally = Customer.create!(first_name: "Sally", last_name: "Sunshine")
      invoice_1 = sally.invoices.create!(status: 1)
      item_1 = Item.create!(name: 'Item 1', description: 'Description 1', unit_price: 100, merchant_id: merchant.id, status: 1)
      item_2 = Item.create!(name: 'Item 2', description: 'Description 2', unit_price: 200, merchant_id: merchant.id, status: 1)
      item_3 = Item.create!(name: 'Item 3', description: 'Description 3', unit_price: 300, merchant_id: merchant.id, status: 1)
      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 100, status: 1)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 2, unit_price: 200, status: 1)
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 300, status: 1)

      expect(invoice_1.total_revenue).to eq(1400)
    end

    it 'can calculate the total discounted revenue' do
      discount_a = Discount.create!(merchant_id: merchant_a.id, percent: 20, qty_threshold: 10)
      discount_b = Discount.create!(merchant_id: merchant_a.id, percent: 30, qty_threshold: 15)
      invoice_item_a = InvoiceItem.create!(item_id: item_a.id, invoice_id: invoice_a.id, quantity: 12, unit_price: 100, status: 1)
      invoice_item_b = InvoiceItem.create!(item_id: item_b.id, invoice_id: invoice_a.id, quantity: 15, unit_price: 200, status: 1)
      
      expect(invoice_item_a.invoice_item_discount(invoice_item_a).percent).to eq(20)
      expect(invoice_item_b.invoice_item_discount(invoice_item_b).percent).to eq(30)

      expect(invoice_a.total_revenue).to eq(4200)
      expect(invoice_a.total_discounted_revenue).to eq(3060.0)
    end
  end

  describe 'bulk discounts' do
    it 'does not apply a discount when the quantity threshold is not met' do
      discount_a = Discount.create!(merchant_id: merchant_a.id, percent: 20, qty_threshold: 10)
      discount_b = Discount.create!(merchant_id: merchant_a.id, percent: 22, qty_threshold: 22)
      invoice_item_a = InvoiceItem.create!(item_id: item_a.id, invoice_id: invoice_a.id, quantity: 5, unit_price: 100, status: 1)
      invoice_item_b = InvoiceItem.create!(item_id: item_b.id, invoice_id: invoice_a.id, quantity: 5, unit_price: 200, status: 1)

      expect(invoice_item_a.discount_available?(invoice_item_a)).to eq(false)
      expect(invoice_item_b.discount_available?(invoice_item_b)).to eq(false)

      expect(invoice_a.total_revenue).to eq(1500)
      expect(invoice_a.total_discounted_revenue).to eq(1500)
    end

    it 'applies a discount when the quantity threshold is met' do
      discount_a = Discount.create!(merchant_id: merchant_a.id, percent: 20, qty_threshold: 10)
      discount_b = Discount.create!(merchant_id: merchant_a.id, percent: 22, qty_threshold: 22)
      invoice_item_a = InvoiceItem.create!(item_id: item_a.id, invoice_id: invoice_a.id, quantity: 10, unit_price: 100, status: 1)
      invoice_item_b = InvoiceItem.create!(item_id: item_b.id, invoice_id: invoice_a.id, quantity: 5, unit_price: 200, status: 1)
      
      expect(invoice_item_a.discount_available?(invoice_item_a)).to eq(true)
      expect(invoice_item_b.discount_available?(invoice_item_b)).to eq(false)
      
      expect(invoice_item_a.discount_applied?).to eq(false)
      expect(invoice_item_b.discount_applied?).to eq(false)
      
      expect(invoice_item_a.invoice_item_discount(invoice_item_a).percent).to eq(20)
      
      expect(invoice_a.total_revenue).to eq(2000)
      expect(invoice_a.total_discounted_revenue).to eq(1800.0)
    end
    
    it 'applies the correct discount to the correct items' do
      discount_a = Discount.create!(merchant_id: merchant_a.id, percent: 20, qty_threshold: 10)
      discount_b = Discount.create!(merchant_id: merchant_a.id, percent: 30, qty_threshold: 15)
      invoice_item_a = InvoiceItem.create!(item_id: item_a.id, invoice_id: invoice_a.id, quantity: 12, unit_price: 100, status: 1)
      invoice_item_b = InvoiceItem.create!(item_id: item_b.id, invoice_id: invoice_a.id, quantity: 15, unit_price: 200, status: 1)
      
      expect(invoice_item_a.invoice_item_discount(invoice_item_a).percent).to eq(20)
      expect(invoice_item_b.invoice_item_discount(invoice_item_b).percent).to eq(30)

      expect(invoice_a.total_revenue).to eq(4200)
      expect(invoice_a.total_discounted_revenue).to eq(3060.0)
    end

    it 'always uses the highest discount available' do
      discount_a = Discount.create!(merchant_id: merchant_a.id, percent: 20, qty_threshold: 10)
      discount_b = Discount.create!(merchant_id: merchant_a.id, percent: 15, qty_threshold: 15)
      invoice_item_a = InvoiceItem.create!(item_id: item_a.id, invoice_id: invoice_a.id, quantity: 12, unit_price: 100, status: 1)
      invoice_item_b = InvoiceItem.create!(item_id: item_b.id, invoice_id: invoice_a.id, quantity: 15, unit_price: 200, status: 1)

      expect(invoice_item_a.invoice_item_discount(invoice_item_a).percent).to eq(20)
      expect(invoice_item_b.invoice_item_discount(invoice_item_b).percent).to eq(20)

      expect(invoice_a.total_revenue).to eq(4200)
      expect(invoice_a.total_discounted_revenue).to eq(3360.0)
    end

    it 'only applies the correct merchant discount to the correct merchant items' do
      discount_a = Discount.create!(merchant_id: merchant_a.id, percent: 20, qty_threshold: 10)
      discount_b = Discount.create!(merchant_id: merchant_a.id, percent: 30, qty_threshold: 15)
      item_aa = Item.create!(name: 'item_aa', description: 'item_aa', unit_price: 100, merchant_id: merchant_a.id)
      item_b1 = Item.create!(name: 'item_b', description: 'item_b', unit_price: 200, merchant_id: merchant_b.id)
      invoice_item_a = InvoiceItem.create!(item_id: item_a.id, invoice_id: invoice_a.id, quantity: 12, unit_price: 100, status: 1)
      invoice_item_aa = InvoiceItem.create!(item_id: item_aa.id, invoice_id: invoice_a.id, quantity: 15, unit_price: 200, status: 1)
      invoice_item_b1 = InvoiceItem.create!(item_id: item_b1.id, invoice_id: invoice_a.id, quantity: 15, unit_price: 200, status: 1)

      expect(invoice_item_a.invoice_item_discount(invoice_item_a).percent).to eq(20)
      expect(invoice_item_aa.invoice_item_discount(invoice_item_aa).percent).to eq(30)
      expect(invoice_item_b1.invoice_item_discount(invoice_item_b1)).to eq(nil)

      expect(invoice_a.total_revenue).to eq(7200)
      expect(invoice_a.total_discounted_revenue).to eq(6060.0)
    end
  end
end
