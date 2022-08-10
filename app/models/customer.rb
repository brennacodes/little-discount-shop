class Customer < ApplicationRecord  
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates_presence_of :first_name, :last_name

  def full_name
    "#{first_name} #{last_name}"
  end

  def successful_transactions
    transactions.where(result: :success).count
  end

  def self.top_5_customers
    # Customer.all.order(created_at: :desc).limit(5)
    joins(:invoices, :transactions)
        .where(transactions: {result: 0})
        .select("customers.*, count(transactions.result) as success_count")
        .group(:id)
        .order(success_count: :desc)
        .limit(5)
  end
end

