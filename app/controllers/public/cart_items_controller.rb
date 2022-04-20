class Public::CartItemsController < Public::ApplicationController

  def index
    @cart_items = current_customer.cart_items
    @total_payment_no_shipfee = CartItem.total_payment_no_shipfee(@cart_items)
  end

  def create
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if (params[:cart_item][:amount]).to_i <= 10
      if @cart_item.update(cart_item_update_params)
        redirect_to request.referer, notice: "カート内の商品(#{@cart_item.item.name})の数量を変更しました。"
      else
        redirect_to request.referer, notice: "数量の更新が反映されませんでした。再度お試しください。"
      end
    else
      redirect_to request.referer, notice: "数量は10個以内でご指定ください。"
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.destroy
      redirect_to request.referer, notice: "カート内の商品を1件(#{cart_item.item.name})削除しました。"
    else
      redirect_to request.referer, notice: "削除が正常に完了しませんでした。再度お試しください。"
    end
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    if @cart_items
      @cart_items.each do |cart_item|
        cart_item.destroy
      end
      redirect_to request.referer, notice: "カート内の商品は全て削除されました。"
    else
      redirect_to request.referer, notice: "削除が正常に完了しませんでした。再度お試しください。"
    end
  end

  private
  def cart_item_update_params
    params.require(:cart_item).permit(:amount)
  end


end
