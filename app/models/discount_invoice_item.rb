class DiscountInvoiceItem < ApplicationRecord
  belongs_to :discount
  belongs_to :invoice_item

  has_one :merchant, through: :discount
  has_one :item, through: :invoice_item
end
