module Api
  module V1
    module Items
      class MerchantsController < ApplicationController
        def show
          item = Item.find(params[:item_id])
          merchant = item.merchant
          json_response(MerchantSerializer.new(merchant))
        end
      end
    end
  end
end