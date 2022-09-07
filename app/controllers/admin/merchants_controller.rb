class Admin::MerchantsController < Admin::BaseController
  include Pagy::Backend

  def index
    @merchants = Merchant.all
    @pagy, @disabled_merchants = pagy(Merchant.disabled_merchants, items: 10)
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def new
    @merchant = Merchant.new
  end

  def update
    @merchant = Merchant.find(params[:id])
    
    if params[:status]
      @merchant.update(status: params[:status])
      redirect_to admin_merchants_path, notice: "Merchant updated successfully"
    elsif @merchant.update(merchant_params)
      redirect_to admin_merchants_path, notice: 'Merchant was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    merchant = Merchant.new(merchant_params)

    if merchant.save
      redirect_to admin_merchants_path, notice: "Merchant created successfully"
    else
      render :new, notice: "Merchant not created"
    end
  end

   private
     def merchant_params
       params.require(:merchant).permit(:name, :status)
     end
 end
