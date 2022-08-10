class Transaction < ApplicationRecord
  belongs_to :invoice

  has_one :customer, through: :invoice

  has_many :invoice_items, through: :invoice
  has_many :items, through: :invoice_items
  has_many :merchants, through: :invoice, source: :items
  
  enum result: { success: 0, failed: 1 }

  validates_presence_of :invoice_id, :credit_card_number, :result
end
