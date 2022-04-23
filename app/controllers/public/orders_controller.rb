class Public::OrdersController < Public::ApplicationController
  def index
    @orders = current_customer.orders.page(params[:page])
  end

  def show
    @order = current_customer.orders.find(params[:id])
  end

  def new
    @order = Order.new
    @shipping_info = ShippingAddress.customer_relation(current_customer)
  end

  def create
    cart_items = current_customer.cart_items
    order = Order.new(order_params)
    order.customer_id = current_customer.id
    order.total_payment = CartItem.total_payment_no_shipfee(cart_items) + params[:order][:shipping_fee].to_i
    if order.save
      save_order = Order.find_by(id: Order.where("customer_id = ?", current_customer.id).maximum(:id))
      cart_items.each do |ci|
        order_details = OrderDetail.new(order_id: save_order.id )
        order_details.item_id = ci.item.id
        order_details.amount = ci.amount
        order_details.price = (ci.item.price_non_tax * 1.1).floor
        order_details.save
        ci.destroy
      end
      redirect_to complete_orders_path
    else
      #エラー処理を定義
      redirect_to root_path
    end
  end

  def order_preconfirm
    #ラジオボタンの選択を判断するためのフラグを定義
    address_radio_type_current_customer = "1"
    address_radio_type_shippingMT = "2"
    address_radio_type_newInput = "3"

    @cart_items = current_customer.cart_items
    @payment_type_key = params[:order][:payment_type]
    @payment_type_value = Order.payment_types[:"#{@payment_type_key}"]
    @shipping_fee = 800
    @total_payment_no_shipfee = CartItem.total_payment_no_shipfee(@cart_items)
    @total_payment = @total_payment_no_shipfee + @shipping_fee

    @order = Order.new

    case params[:order][:address_radio_type]
    when address_radio_type_current_customer then
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
    params.require(:order).permit(:payment_type, :post_code, :address, :to_name, :shipping_fee)
  end

end
