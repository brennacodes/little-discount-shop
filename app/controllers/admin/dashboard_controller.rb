class Admin::DashboardController < ApplicationController
  include Pagy::Backend
  
   def index
      @customers = Customer.all
      @pagy, @invoices = pagy(Invoice.all, items: 15)
   end
end