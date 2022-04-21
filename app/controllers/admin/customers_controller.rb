class Admin::CustomersController < Admin::ApplicationController
  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
       @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
       flash[:notice] = "succerssfully"
       redirect_to admin_customer_path(@customer)
    else
       render :edit
    end
  end

  def index_order
    @customer = Customer.find(params[:id])
    @orders = @customer.orders
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :phone_number, :email, :is_deleted)
  end

end
