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
    # binding.pry
    # address_radio_type_customerMT = 1
    # address_radio_type_shippingMT = 2
    # address_radio_type_newInput = 3

    # case params[:order][:address_radio_type]
    # when address_radio_type_customerMT then
    #   @payment_type = a
    #   # ログイン顧客の住所情報を結合して格納する
    #   @shipping_address = b
    # when address_radio_type_shippingMT
    #   @payment_type = a
    #   # セレクトボックスの配送先IDを元に検索し値を格納する
    #   @shipping_address = b
    # when address_radio_type_newInput
    #   @payment_type = a
    #   # 送信パラメータの入力内容を結合して配送先住所を設定する
    #   @shipping_address = b
    # else
    #   #エラーメッセージを返す
    # end
    # render "show",{ customer: @customer, url: order_path(@customer.id) }
  end

  def complete
  end
end
