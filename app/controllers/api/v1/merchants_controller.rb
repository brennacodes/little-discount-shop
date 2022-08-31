module Api
  module V1
    class MerchantsController < ApplicationController
      def index
        merchants = Merchant.all
        serialize_merchant(merchants)
      end

      def show
        merchant = Merchant.find(params[:id])
        serialize_merchant(merchant)
      end
    end
  end
end