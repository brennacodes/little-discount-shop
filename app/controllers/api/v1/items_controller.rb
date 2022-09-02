module Api
  module V1
    class ItemsController < ApplicationController
      before_action :set_item, only: %i[ show update destroy ]

      def index
        items = Item.all
        serialize_item(items)
      end

      def show
        serialize_item(@item)
      end

      def create
        item = Item.new(item_params)

        if item.save
          serialize_item(item, :created)
        else
          json_response(item.errors, :unprocessable_entity)
        end
      end

      def update
        check = check_input
        if check.values.any? == false
          json_response(@item.errors, :unprocessable_entity)
        elsif @item.update(item_params)
          serialize_item(@item, :ok)
        else 
          json_not_found(find_type, params[find_type.to_sym])
        end
      end

      def destroy
        @item.destroy
      end

      private
        def set_item
          @item = Item.find(params[:id])
        end

        def item_params
          params.require(:item).permit(:name, :description, :unit_price, :precision, :merchant_id)
        end
    end
  end
end