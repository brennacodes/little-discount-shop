class CreateDiscountInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :discount_invoice_items do |t|
      t.references :discount, foreign_key: true
      t.references :invoice_item, foreign_key: true

      t.timestamps
    end
  end
end
