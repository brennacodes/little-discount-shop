class Discount < ApplicationRecord
  before_destroy :can_destroy?, prepend: true

  belongs_to :merchant

  has_many :discount_invoice_items, dependent: :delete_all
  has_many :invoice_items, through: :discount_invoice_items
  has_many :items, through: :discount_invoice_items, source: :invoice_item
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :percent, :qty_threshold 
  validates_numericality_of :percent, { greater_than_or_equal_to: 1, less_than_or_equal_to: 99 }
  validates_numericality_of :qty_threshold, { greater_than_or_equal_to: 2 }

  def has_pending_invoices?
    invoice_items.where(status: "pending").any?
  end

  def self.discount_conflicts?(discount_params, merchant_id = nil)
    conflict = Discount.where(merchant_id: merchant_id)
    conflict = conflict.where(percent: discount_params[:percent]).or(conflict.where(qty_threshold: discount_params[:qty_threshold]))
    if conflict.any?
      @conflicting_discounts = conflict
      true
    else
      false
    end
  end

  def self.holiday_discount_exists?(id, name)
    where(merchant_id: id).where("name ILIKE ?", "%#{ name }%").exists?
  end

  def self.find_holiday_discount(name)
    where(name: name).first
  end

  def holiday_discount(name)
    Discount.where(name: name)
  end

  def can_destroy?
    if has_pending_invoices?
      errors.add(:base, "Cannot delete discount with pending invoices")
      throw :abort
    else
      true
    end
  end
end
