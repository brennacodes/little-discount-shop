class InvoiceItemsController < ApplicationController
  def edit
    @invoice_item = InvoiceItem.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice_item = InvoiceItem.find(params[:id])
    @invoice_item.update!(status: params[:invoice_item][:status])
    redirect_to merchant_invoice_path(@merchant, @invoice_item.invoice_id)
  end

  private
    def invoice_item_params
      params.require(:invoice_item).permit(:item_id, :invoice_id, :quantity, :unit_price, :status)
    end
end