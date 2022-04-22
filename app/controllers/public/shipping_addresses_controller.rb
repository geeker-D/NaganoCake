class Public::ShippingAddressesController < Public::ApplicationController
  def index
    @shipping_address = ShippingAddress.new
    @shipping_addresses = current_customer.shipping_addresses
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    @shipping_address.customer_id = current_customer.id
    if @shipping_address.save
      redirect_to shipping_addresses_path, notice: "新規配送先を登録しました"
    else
      @shipping_addresses = current_customer.shipping_addresses
      render 'index'
    end
  end

  def update
    @shipping_address = ShippingAddress.find(params[:id])
    if @shipping_address.update(shipping_address_params)
      redirect_to shipping_addresses_path, notice: "配送先を変更しました"
    else
      @shipping_address = ShippingAddress.new
      @shipping_addresses = ShippingAddress.all
      render 'index'
    end
  end

  def destroy
    shipping_address = ShippingAddress.find(params[:id])
    shipping_address.destroy
    redirect_to shipping_addresses_path, notice: "配送先を削除しました"
  end
  
  private
  def shipping_address_params
    params.require(:shipping_address).permit(:post_code, :address, :to_name, :customer_id)
  end
end
