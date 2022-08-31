module Api
  module V1
    module Items
      class SearchController < ApplicationController
        def index
          if (too_many_params == true) || (nil_check == true)
            json_missing_input
          elsif check_input == nil
            check = check_input
            json_not_found(check[0], check[1])
          else
            serialize_item(Item.find_all_by_input(check_input[0], check_input[1]))
          end
        end

        def show
          if (too_many_params == true) || (nil_check == true)
            json_missing_input
          elsif check_input == nil
            check = check_input
            json_not_found(check[0], check[1])
          else
            item = Item.find_by_input(check_input[0], check_input[1])
            return json_not_found(check_input[0], check_input[1]) if item == nil
            serialize_item(item)
          end
        end

        private
          def nil_check
            return true if check_input == nil
          end

          # It checks to see if the user has entered any search parameters, 
          # and if not, it returns a 204 status code and an error message
          def check_input
            type = find_type
            return nil if type == nil
            if type == ("unit_price_max" || "unit_price_min" || "unit_price")
              if (type == ("unit_price_min" || "unit_price")) && (params[type.to_sym].to_i < 0) 
                return nil 
              else
                return [type, params[type.to_sym].to_i]
              end
            elsif params[type.to_sym].empty?
              return nil
            else
              [type, params[type.to_sym]]
            end
          end

          def item_params
            params.permit(:name, :description, :unit_price, :merchant_id, :unit_price_max, :unit_price_min)
          end
      end
    end
  end
end