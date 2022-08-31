module Api
  module V1
    module Merchants
      class SearchController < ApplicationController
        # This function takes in a name parameter and returns a list of merchants that match the name
        def index
          merchants = Merchant.find_all_by_input(params[:name])
          serialize_merchant(merchants)
        end

        # If the params hash has an id key, find the merchant by id, 
        # otherwise find the merchant by name
        def show
          if params[:name] == nil || params[:name] == ""
            return json_missing_input
          elsif Merchant.find_by_input(params[:name]) == nil
            check = check_input
            return json_not_found(check[0], check[1])
          else
            serialize_merchant(Merchant.find_by_input(params[:name]))
          end
        end

        private
          # It returns an array of the type of input and the input itself, 
          # or nil if either is empty
          def check_input
            type = find_type
            input = params[type.to_sym]
            type.empty? || input.empty? ? nil : [type, input]
          end

          def merchant_params
            params.permit(:name)
          end
      end
    end
  end
end