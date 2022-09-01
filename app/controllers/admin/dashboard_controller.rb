class Admin::DashboardController < Admin::BaseController
  def index
    @customers = Customer.all
    @pagy, @invoices = pagy(Invoice.all, items: 15)
  end
end