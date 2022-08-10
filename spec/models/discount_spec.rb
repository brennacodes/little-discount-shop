require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:percent) }
    it { should validate_presence_of(:qty_threshold) }
    it { should validate_numericality_of(:percent).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(99) }
    it { should validate_numericality_of(:qty_threshold).is_greater_than_or_equal_to(2) }
  end

  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:discount_invoice_items) }
    it { should have_many(:invoice_items).through(:discount_invoice_items) }
    it { should have_many(:items).through(:discount_invoice_items).source(:invoice_item) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'class methods' do
    it 'can tell if a discount has conflicts' do
      merchant = Merchant.create(name: "Merchant 1")
      discount = Discount.create(merchant_id: merchant.id, name: "Labor", percent: 10, qty_threshold: 3)

      discount_1 = Discount.create(merchant_id: merchant.id, name: "Christmas", percent: 10, qty_threshold: 3)
      discount_2 = Discount.new(merchant_id: merchant.id, name: "Labor", percent: 10, qty_threshold: 3)

      expect(Discount.discount_conflicts?(discount_2)).to eq(false)
    end

    it 'can tell if a holiday discount exists' do
      merchant = Merchant.create!(name: 'Merchant 1')
      discount = Discount.create!(merchant_id: merchant.id, name: 'Sale sale sale!', percent: 77, qty_threshold: 8)

      expect(Discount.holiday_discount_exists?(merchant.id, 'Sale sale sale!')).to eq(true)
      expect(Discount.holiday_discount_exists?(merchant.id, 'Not a holiday discount')).to eq(false)
    end

    it 'has a class method to find holiday discount' do
      merchant = Merchant.create!(name: 'Merchant 1')
      discount = Discount.create!(merchant_id: merchant.id, name: 'Holiday Discount', percent: 10, qty_threshold: 10)

      expect(Discount.find_holiday_discount(discount.name)).to eq(discount)
      expect(Discount.holiday_discount_exists?(merchant.id, discount.name)).to eq(true)
      expect(Discount.holiday_discount_exists?(merchant.id, 'Not a Holiday Discount')).to eq(false)
    end
  end

  describe 'instance methods' do
    it 'can return discounts that match a holiday name' do
      merchant = Merchant.create!(name: 'Merchant 1')
      customer = Customer.create!(first_name: 'John', last_name: 'Doe')
      discount = Discount.create!(merchant_id: merchant.id, percent: 33, qty_threshold: 3)
      discount_2 = Discount.create!(merchant_id: merchant.id, percent: 22, qty_threshold: 22, name: "Christmas")
      item = Item.create!(name: 'Item 1', description: 'Item 1 description', unit_price: 10, merchant_id: merchant.id)
      invoice = Invoice.create!(customer_id: customer.id, status: 1)
      invoice_item = InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, quantity: 10, unit_price: 10, status: 'pending')
      discount_invoice_item = DiscountInvoiceItem.create!(discount_id: discount.id, invoice_item_id: invoice_item.id)

      expect(discount.holiday_discount("Christmas")).to eq([discount_2])
    end

    it 'can tell if a discount can be destroyed' do
      merchant = Merchant.create!(name: 'Merchant 1')
      customer = Customer.create!(first_name: 'John', last_name: 'Doe')
      discount = Discount.create!(merchant_id: merchant.id, percent: 33, qty_threshold: 3)
      discount_2 = Discount.create!(merchant_id: merchant.id, percent: 22, qty_threshold: 22)
      item = Item.create!(name: 'Item 1', description: 'Item 1 description', unit_price: 10, merchant_id: merchant.id)
      invoice = Invoice.create!(customer_id: customer.id, status: 1)
      invoice_item = InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, quantity: 10, unit_price: 10, status: 'pending')
      discount_invoice_item = DiscountInvoiceItem.create!(discount_id: discount.id, invoice_item_id: invoice_item.id)

      expect(discount_2.can_destroy?).to eq(true)
    end
    it 'can tell if a discount has pending invoices' do
      merchant = Merchant.create!(name: 'Merchant 1')
      customer = Customer.create!(first_name: 'John', last_name: 'Doe')
      discount = Discount.create!(merchant_id: merchant.id, percent: 33, qty_threshold: 3)
      discount_2 = Discount.create!(merchant_id: merchant.id, percent: 22, qty_threshold: 22)
      item = Item.create!(name: 'Item 1', description: 'Item 1 description', unit_price: 10, merchant_id: merchant.id)
      invoice = Invoice.create!(customer_id: customer.id, status: 1)
      invoice_item = InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, quantity: 10, unit_price: 10, status: 'pending')
      discount_invoice_item = DiscountInvoiceItem.create!(discount_id: discount.id, invoice_item_id: invoice_item.id)

      expect(discount.has_pending_invoices?).to eq(true)
      expect(discount_2.has_pending_invoices?).to eq(false)
    end
  end

  describe 'private methods' do
    it 'can destroy a discount if it has no pending invoices' do
      merchant = Merchant.create!(name: 'Merchant 1')
      customer = Customer.create!(first_name: 'John', last_name: 'Doe')
      discount = Discount.create!(merchant_id: merchant.id, percent: 33, qty_threshold: 3)
      discount_2 = Discount.create!(merchant_id: merchant.id, percent: 22, qty_threshold: 22)
      item = Item.create!(name: 'Item 1', description: 'Item 1 description', unit_price: 10, merchant_id: merchant.id)
      invoice = Invoice.create!(customer_id: customer.id, status: 1)
      invoice_item = InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, quantity: 10, unit_price: 10, status: 'pending')
      discount_invoice_item = DiscountInvoiceItem.create!(discount_id: discount.id, invoice_item_id: invoice_item.id)

      expect(discount.destroy).to eq(false)
      expect(discount_2.destroy).not_to eq(false)
    end
  end
end
