module Api
  module V1
    module Items
      class SearchController < ApplicationController
        # If there are too many parameters, or if the parameters are nil, then return a json error message. If
        # the parameters are not nil, but the item is not found, then return a json error message. Otherwise,
        # return the serialized item
        def index
          check = check_input
          return json_check_input if too_many_params || check.values.any? == false
            if check.keys[0].include?("price")
              items = Item.find_all_by_input(check.keys[0], params[check.keys[0].to_sym].to_f)
            elsif check.keys[0] == "merchant_id"
              items = Item.find_all_by_input(check.keys[0], params[check.keys[0].to_sym].to_i)
            else 
              items = Item.find_all_by_input(check.keys[0], params[check.keys[0].to_sym])
            end
          return json_not_found(check.keys[0], params[check.keys[0].to_sym]) if items == []
          serialize_item(items)
        end

        def show
          check = check_input
          return json_check_input if too_many_params || check.values.any? == false
            if check.keys[0].include?("price")
              item = Item.find_by_input(check.keys[0], params[check.keys[0].to_sym].to_f)
            elsif check.keys[0] == "merchant_id"
              item = Item.find_by_input(check.keys[0], params[check.keys[0].to_sym].to_i)
            else 
              item = Item.find_by_input(check.keys[0], params[check.keys[0].to_sym])
            end
          return json_not_found(check.keys[0], params[check.keys[0].to_sym]) if item == []
          serialize_item(item)
        end

        private
          def item_params
            params.permit(:name, :description, :unit_price, :merchant_id, :unit_price_max, :unit_price_min)
          end
      end
    end
  end
end