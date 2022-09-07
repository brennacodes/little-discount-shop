class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  enum status: { disabled: 0, enabled: 1 }
  
  after_destroy :delete_empty_invoices

  validates_presence_of :description

  validates_presence_of :unit_price, numericality: { greater_than: 0 }
  validates_presence_of :merchant_id, only_integer: true
  validates :name, presence: true, format: { with: /\D/, 
                                  message: "must contain at least one letter" } 
  
  def status_options
    Item.statuses.keys
  end

  def delete_empty_invoices
    invoices.each { |inv| inv.items.distinct.count == 1 ? inv.destroy : nil }
  end

  def self.find_by_input(type = "id", input)
    return find(input) if type == "id"
    return where(merchant_id: input).order(merchant_id: :asc).first if type == "merchant_id"
    return where("name ILIKE ?", "%#{input}%").order(name: :asc).first if type == "name"
    return where("description ILIKE ?", "%#{input}%").order(description: :asc).first if type == "description"
    return where(unit_price: input).order(unit_price: :asc).first if type == "unit_price"
  end

  def self.find_all_by_input(type = "id", input)
    return find(input) if type == "id"
    return where(merchant_id: input).order(merchant_id: :asc) if type == "merchant_id"
    return where("name ILIKE ?", "%#{input}%").order(name: :asc) if type == "name"
    return where("description ILIKE ?", "%#{input}%").order(description: :asc) if type == "description"
    return where("unit_price < ?", input).order(unit_price: :asc) if type == "unit_price_max"
    return where("unit_price > ?", input).order(unit_price: :asc) if type == "unit_price_min"
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

  # these methods are for the api
  def self.find_by_input(type = "id", input)
    return find(input) if type == "id"
    return where(merchant_id: input).order(merchant_id: :asc).first if type == "merchant_id" 
    return where("name ILIKE ?", "%#{input}%").order(name: :asc).first if type == "name"
    return where("description ILIKE ?", "%#{input}%").order(description: :asc).first if type == "description"
    self.find_by_unit_price(type, input)
  end

  def self.find_by_unit_price(type, input)
    input = (input.to_i * 100)
    return where(unit_price: input).order(unit_price: :asc).first if type == "unit_price"
    return where("unit_price < ?", input).order(unit_price: :asc).first if type == "unit_price_max"
    return where("unit_price > ?", input).order(unit_price: :asc).first if type == "unit_price_min"
  end

  def self.find_all_by_input(type = "id", input)
    return find(input) if type == "id"
    return where(merchant_id: input).order(merchant_id: :asc) if type == "merchant_id"
    return where("name ILIKE ?", "%#{input}%").order(name: :asc) if type == "name"
    return where("description ILIKE ?", "%#{input}%").order(description: :asc) if type == "description"
    self.find_all_by_unit_price(type, input)
  end

  def self.find_all_by_unit_price(type, input)
    input = (input.to_i * 100)
    return where("unit_price < ?", input).order(unit_price: :asc) if type == "unit_price_max"
    return where("unit_price > ?", input).order(unit_price: :asc) if type == "unit_price_min"
  end
end
