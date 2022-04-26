class Public::OrdersController < Public::ApplicationController

  def index
    @orders = current_customer.orders.page(params[:page]).per(8).order(id: "DESC")
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
      redirect_to controller: 'cart_items', action: 'index'
    end
  end


  def order_preconfirm
    ##############以下注文確定処理に必要なフォーム送信データ#############
    @payment_type_key = params[:order][:payment_type]
    @shipping_fee = 800

    ##############以下注文確認画面の表示用データ#############
    @cart_items = current_customer.cart_items
    @total_payment_no_shipfee = CartItem.total_payment_no_shipfee(@cart_items)
    @total_payment = @total_payment_no_shipfee + @shipping_fee
    @order = Order.new

    ##############以下注文確定処理に必要なフォーム送信データ#############
    #住所のラジオボタン選択を判断するためのフラグを定義
    radio_type_current_customer = "1"
    radio_type_registered_shipping_address = "2"
    radio_type_newInput = "3"

    case params[:order][:address_radio_type]
    when radio_type_current_customer then
      if current_customer.post_code.length == 7
        @post_code = current_customer.post_code
        @address = current_customer.address
        @to_name = current_customer.last_name + current_customer.first_name
      else
        redirect_to request.referer, notice: "郵便番号は7桁でご指定ください。。(マイページの編集画面で変更ください。)"
      end
    when radio_type_registered_shipping_address then
      if params[:order][:shipping_address_id].blank?
        redirect_to request.referer, notice: "登録済の配送先住所が存在しません。ご自身の住所を選択、もしくは新しいお届け先をご入力ください。"
      else
        ship_address = ShippingAddress.find(params[:order][:shipping_address_id])
        if ship_address.post_code.length == 7
          @post_code = ship_address.post_code
          @address = ship_address.address
          @to_name = ship_address.to_name
        else
          redirect_to request.referer, notice: "郵便番号は7桁でご指定ください。(マイページの編集画面で変更ください。)"
        end
      end
    when radio_type_newInput then
      if params[:order][:input_post_code].blank? || params[:order][:input_address].blank? || params[:order][:input_to_name].blank?
        redirect_to request.referer, notice: "郵便番号、住所、宛名のいずれかの入力が確認できません。再度入力ください。"
      else
        if params[:order][:input_post_code].length == 7
          @post_code = params[:order][:input_post_code]
          @address = params[:order][:input_address]
          @to_name = params[:order][:input_to_name]
        else
          redirect_to request.referer, notice: "郵便番号は7桁で再度入力ください。"
        end
      end
    else
      redirect_to request.referer, notice: "処理を正常に完了することができません。サポートにお問い合わせください。"
    end

  end


  def complete
  end


  private
  def order_params
    params.require(:order).permit(:payment_type, :post_code, :address, :to_name, :shipping_fee)
  end


end
