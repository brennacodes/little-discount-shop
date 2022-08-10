class Merchant < ApplicationRecord
  has_many :items
  has_many :discounts
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name, presence: true

  enum status: { disabled: 0, enabled: 1 }

  scope :disabled_merchants, -> { where(status: 0) }
  scope :enabled_merchants, -> { where(status: 1) }

  def merchants_discounts
    discounts.distinct
  end
  
  def merchants_items
    items.distinct
  end

  def merchants_invoices
    invoices.distinct
  end

  def enabled_items
    items.where(status: 1).distinct
  end
  
  def disabled_items
    items.where(status: 0).distinct
  end
  
  def top_5_customers
    customers.joins(invoices: :transactions)
      .where(transactions: { result: :success })
      .select("customers.*, COUNT(transactions) as successful_transactions")
      .group(:id)
      .order(successful_transactions: :desc)
      .distinct
      .limit(5)
  end

  def ready_to_ship
    invoice_items.where.not(status: 2).order(created_at: :desc)
  end

  def items_ready_to_ship
    items.joins(:invoice_items, :invoices)
          .where.not(invoice_items: {status: 2})
          .select('items.*')
          .group(:id)
          .order(created_at: :desc)
  end
  
  def top_5_items
    items.joins(:invoice_items, invoices: :transactions)
          .where(transactions: {result: :success})
          .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
          .group(:id)
          .order(revenue: :desc)
          .limit(5)
  end
  
  def self.top_5_merchants
    joins(:invoice_items, :transactions)
      .where(transactions: {result: 0}, invoice_items: {status: 2})
      .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
      .group('merchants.id')
      .order(revenue: :desc)
      .limit(5)
  end

  def top_day
    invoices.select("invoices.created_at, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
      .group(:created_at)
      .order(:total_revenue)
      .first
      .created_at
  end
end
