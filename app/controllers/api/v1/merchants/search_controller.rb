module Api
  module V1
    module Merchants
      class SearchController < ApplicationController
        def index
          check = check_input
          return json_check_input if too_many_params || check.values.any? == false
          merchants = Merchant.find_all_by_input(params[check.keys[0].to_sym])
          return json_not_found(check.keys[0], params[check.keys[0].to_sym]) if merchants == []
          serialize_merchant(merchants)
        end

        def show
          check = check_input
          return json_check_input if too_many_params || check.values.any? == false
          merchant = Merchant.find_by_input(params[check.keys[0].to_sym])
          return json_not_found(check.keys[0], params[check.keys[0].to_sym]) if merchant == []
          serialize_merchant(merchant)
        end

        private
          def merchant_params
            params.permit(:name)
          end
      end
    end
  end
end