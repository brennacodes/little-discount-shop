class MerchantInvoicesController < ApplicationController
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.merchants_invoices
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = @merchant.invoices.find(params[:id])
    @invoice_items = @invoice.invoice_items
  end
end