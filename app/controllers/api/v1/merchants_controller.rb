module Api
  module V1
    class MerchantsController < ApplicationController
      def index
        merchants = Merchant.all
        serialize_merchant(merchants)
      end

      def show
        if Merchant.exists?(params[:id])
          serialize_merchant(Merchant.find(params[:id]))
        elsif !Merchant.exists?(params[:id])
          json_not_found('id', params[:id])
        else
          json_missing_input
        end
      end

      private
        def merchant_params
          params.permit(:id, :name)
        end
    end
  end
end