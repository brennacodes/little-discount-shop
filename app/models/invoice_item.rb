class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  has_one :discount_invoice_item
  has_one :discount, through: :discount_invoice_item
  has_one :merchant, through: :item
  has_one :transactions, through: :invoice
  
  enum status: { "pending" => 0, "packaged" => 1, "shipped" => 2 }

  validates_presence_of :item_id, :invoice_id, :quantity, :unit_price
  validates :status, inclusion: { in: ["packaged", "pending", "shipped"] }

  def self.status_options
    statuses.keys
  end

  def discount_applied?
    discount.present?
  end

  def discount_percentage
    discount == nil ? 0 : discount.percent
  end

  def total
    quantity * unit_price
  end

  def total_discounted(invoice_item)
    (total - (quantity * ( unit_price * ( invoice_item_discount(invoice_item).percent / 100.0 ))))
  end

  def total_discounted_price(invoice_item)
    if discount_applied? 
      invoice_item.total_discounted(invoice_item)
    elsif !discount_applied? && discount_available?(invoice_item)
      apply_discount(invoice_item)
      total_discounted(invoice_item)
    else
      total
    end
  end

  def discount_available?(invoice_item)
    Discount.where("qty_threshold <= ?", invoice_item.quantity).where(merchant_id: invoice_item.item.merchant_id).any?
  end
  
  def invoice_item_discount(invoice_item)
    Discount.where("qty_threshold <= ?", invoice_item.quantity).where(merchant_id: invoice_item.item.merchant_id).order(percent: :desc).first
  end

  def apply_discount(invoice_item)
    DiscountInvoiceItem.create!(discount_id: invoice_item_discount(invoice_item).id, invoice_item_id: invoice_item.id)
  end
end