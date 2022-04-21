class Public::OrdersController < Public::ApplicationController
  def index
  end

  def show
  end

  def new
    @order = Order.new
    @shipping_info = ShippingAddress.where(customer_id: current_customer.id).map{ |sa| ["〒"+sa.post_code+" "+sa.address+" "+sa.to_name, sa.id]}

  end

  def create

  end

  def order_preconfirm

    #ラジオボタンの選択を判断するためのフラグを定義
    address_radio_type_customerMT = "1"
    address_radio_type_shippingMT = "2"
    address_radio_type_newInput = "3"

    @cart_items = current_customer.cart_items
    @payment_type = params[:order][:address_radio_type]
    @shipping_fee = 800
    @total_payment_no_shipfee = CartItem.total_payment_no_shipfee(@cart_items)
    @total_payment = @total_payment_no_shipfee + @shipping_fee

    @order = Order.new
    # binding.pry
    case params[:order][:address_radio_type]
    when address_radio_type_customerMT then
      @post_code = current_customer.post_code
      @address = current_customer.address
    @to_name = current_customer.last_name + current_customer.first_name

    when address_radio_type_shippingMT
      ship_address = ShippingAddress.find(params[:order][:shipping_address_id])
      @post_code = ship_address.post_code
      @address = ship_address.address
      @to_name = ship_address.to_name

    when address_radio_type_newInput
      @post_code = params[:order][:input_post_code]
      @address = params[:order][:input_address]
      @to_name = params[:order][:input_to_name]
    else
      #エラーメッセージを返す処理を定義予定
    end

  end

  def complete
  end

  private
  def order_params
    params.require(:order).permit(:payment_type)
  end

end
