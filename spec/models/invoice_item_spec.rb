require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
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

  describe "relationships" do
    it {should belong_to(:invoice)}
    it {should belong_to(:item)}
  end

  describe 'validations' do
    it {should validate_presence_of(:item_id)}
    it {should validate_presence_of(:invoice_id)}
    it {should validate_presence_of(:quantity)}
    it {should validate_presence_of(:unit_price)}
    it {is_expected.to define_enum_for(:status).with_values(%w(pending packaged shipped))}
  end

  describe 'class methods' do
    it 'can return a list of status options' do
      expect(InvoiceItem.status_options).to eq(%w(pending packaged shipped))
    end
  end

  describe 'instance methods' do
    it 'can return the total' do
      expect(invoice_item_1.total).to eq(500)
    end

    it 'can return the total discounted' do
      expect(invoice_item_1.total_discounted(invoice_item_1)).to eq(400)
    end

    it 'can return whether or not a discount is applied' do
      expect(invoice_item_1.discount_applied?).to eq(true)
    end

    it 'can return whether or not a discount is available' do
      expect(invoice_item_2.discount_available?(invoice_item_2)).to eq(true)
    end

    it 'can locate the available discount' do
      expect(invoice_item_2.invoice_item_discount(invoice_item_2)).to eq(discount_2)
    end

    it 'can apply a discount' do
      applied = invoice_item_2.apply_discount(invoice_item_2)
      expect(applied).to be_instance_of(DiscountInvoiceItem)
    end
  end
end
