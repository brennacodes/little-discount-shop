class Invoice < ApplicationRecord
  belongs_to :customer  

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :discounts, through: :invoice_items
  has_many :discount_invoice_items, through: :invoice_items

  enum status: { cancelled: 0, "in progress" => 1, completed: 2 }

  validates_presence_of :customer_id, :status

  def self.status_options
    statuses.keys
  end

  def self.not_cancelled
    where.not(status: "cancelled")
  end

  def unique_items
    items.uniq!
  end
  
  def total_revenue
    invoice_items.sum { |invoice_item| invoice_item.total }
  end

  def total_discounted_revenue
    invoice_items.sum do |invoice_item| 
      if invoice_item.discount_applied? 
        invoice_item.total_discounted
      elsif !invoice_item.discount_applied? && invoice_item.discount_available?(invoice_item)
        invoice_item.apply_discount(invoice_item)
        invoice_item.total_discounted
      else
        invoice_item.total
      end
    end
  end

  def self.incomplete_invoices
    joins(:invoice_items).where.not(invoice_items: {status: 2}).order(created_at: :asc)
  end
end

