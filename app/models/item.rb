class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  enum status: { disabled: 0, enabled: 1 }
  
  validates_presence_of :merchant_id, :name, :description, :unit_price
  
  def status_options
    Item.statuses.keys
  end

  def self.enabled_items(id)
    where(merchant_id: id, status: "enabled")
  end
  
  def self.disabled_items(id)
    where(merchant_id: id, status: "disabled")
  end

  def top_day
    invoices.select("invoices.created_at, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
            .group(:created_at)
            .order(:total_revenue)
            .first
            .created_at
  end
end
