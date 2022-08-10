class MerchantItemsController < ApplicationController  
  include Pagy::Backend

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @pagy, @items_to_ship = pagy(@merchant.ready_to_ship, items: 10)
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end
  
  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new
  end
  
  def create   
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new

    if @item.save!(item_params)
      redirect_to merchant_items_path(@merchant), notice: "Item was successfully created." 
    else
      render :edit, status: :unprocessable_entity 
    end
  end
  
  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    
    if params[:item]
      @item.update(item_params)
      redirect_to merchant_item_path(@merchant, @item), notice: "Item was successfully updated."
    elsif @item.update(status_params)
      @item.update(status: params[:status])
      redirect_to merchant_items_path(@merchant), notice: "Item was successfully updated." 
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  private
    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end

    def status_params
      params.permit(:status)
    end
end
