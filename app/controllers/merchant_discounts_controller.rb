class MerchantDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.merchants_discounts
    @holidays = PublicHolidaySearch.new
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    if params[:discount]
      @discount = @merchant.discounts.new(discount_params)
    else
      @discount = @merchant.discounts.new
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end
    
  def create   
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.new(discount_params)

    if Discount.discount_conflicts?(@discount)
      @conflicting_discounts = Discount.discount_conflicts?(@discount)
      redirect_to new_merchant_discount_path(@merchant), notice: "Discount could not be created. There may be an existing discount that would conflict. Please check your inputs and try again."
    elsif @discount.save!
      redirect_to merchant_discounts_path(@merchant), notice: "Discount was successfully created." 
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def update
    @discount = Discount.find(params[:id])
    @merchant = @discount.merchant

    if Discount.discount_conflicts?(discount_params, @merchant.id) || @discount.has_pending_invoices?
      redirect_to edit_merchant_discount_path(@merchant, @discount), alert: "Discount could not be updated. There may be an existing discount that would conflict, or the discount may have pending invoices. Please check your inputs and try again."
    elsif @discount.update!(discount_params)
      redirect_to merchant_discount_path(@merchant, @discount), notice: "Discount was successfully updated." 
    else
      rendirect_to edit_merchant_discount_path(@merchant, @discount), alert: "Could not update discount. Please check your inputs and try again."
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
    @discount.destroy
    redirect_to merchant_discounts_path(@merchant)
  end

  private
    def discount_params
      params.require(:discount).permit(:merchant_id, :name, :percent, :qty_threshold, :holiday_date)
    end

    def merchant_id_params
      params.require(:merchant_id)
    end
end