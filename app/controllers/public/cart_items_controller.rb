class Public::CartItemsController < Public::ApplicationController
  def index
    @cart_items = current_customer.cart_items
    #合計金額(送料なし、税込み)
    @total_payment_no_shipfee = 0
    @cart_items.each do |cart_item|
      @total_payment_no_shipfee += (cart_item.item.price_non_tax * 1.1).floor * cart_item.amount
    end

    # @total_payment_no_shipfee = customer.items.total_payment_no_shipfee
  end

  def create
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to request.referer, notice: "カート内の商品(#{@cart_item.item.name})の数量を変更しました。"
    else
      # render "index"
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to request.referer, notice: "カート内の商品を1件(#{cart_item.item.name})削除しました。"
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      cart_item.destroy
    end
    redirect_to request.referer, notice: "カート内の商品は全て削除されました。"
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount)
  end


end
