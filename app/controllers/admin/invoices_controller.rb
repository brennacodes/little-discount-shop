class Admin::InvoicesController < Admin::BaseController
  include Pagy::Backend

  def index
    @pagy, @invoices = pagy(Invoice.all, items: 10)
  end

  def show
    @invoice = Invoice.find(params[:id])
  end 

  def update
    invoice = Invoice.find(params[:id])
    invoice.update(invoice_params)
    invoice.save
    if (invoice.status == 2) && (invoice.updated_at == Date.today)
      invoice.create_discount_invoice_items(invoice)
    end
    redirect_to "/admin/invoices/#{invoice.id}"
  end

  def invoice_params
    params.permit(:id, :status, :created_at, :updated_at)
  end
end