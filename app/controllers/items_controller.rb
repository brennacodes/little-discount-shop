class ItemsController < ApplicationController
  include ApplicationHelper

  def index
    # @merchant = Merchant.find(params[:merchant_id])
    @enabled_items = Item.enabled_items(params[:id])
    @disabled_items = Item.disabled_items(params[:id])
  end

  def show
    # @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def create

    merchant = Merchant.find(params[:id])

    item = merchant.items.create(merchants_item_params)

    redirect_to "/merchants/#{merchant.id}/items"
  end


  def edit
    # @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  # def change_status
  #   merchant = Merchant.find(params[:merchant_id])
  #   item = Item.find(params[:item_id])
  #   item.update_status(item)
  #   redirect_to merchant_items_path(merchant.id)
  # end

  def update
    @item = Item.find(params[:id])
    if params[:update_status]
      if @item.update_status(@item)
        redirect_to merchant_items_path(@merchant.id), notice: "Item status has been successfully updated!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    if params[:merchant] 
      @merchant = Merchant.find(params[:merchant][:id])
    end
  end


  private
    def merchant_params
      params.permit(:name)
    end

    def merchants_item_params
      params.permit(:merchant_id, :name, :description, :unit_price, :status)
    end
end