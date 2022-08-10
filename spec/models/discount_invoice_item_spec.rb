require 'rails_helper'

RSpec.describe DiscountInvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:discount) }
    it { should belong_to(:invoice_item) }
    it { should have_one(:item).through(:invoice_item) }
  end
end
