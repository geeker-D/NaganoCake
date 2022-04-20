class Public::CartItemsController < Public::ApplicationController

  def index
    @cart_items = current_customer.cart_items
    @total_payment_no_shipfee = CartItem.total_payment_no_shipfee(@cart_items)
  end

  def create
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item_now = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item_now.amount += params[:cart_item][:amount].to_i
      @cart_item_now.update(amount: @cart_item_now.amount)
      if @cart_item_now.amount <= 10 && params[:cart_item][:amount].to_i != 0
        redirect_to cart_items_path, notice: "#{@cart_item_now.item.name}をカートに追加しました。"
      elsif @cart_item_now.amount > 10
        redirect_to request.referer, notice: "#{@cart_item_now.item.name}の合計が10個以内になるように選択してください"
      else 
        redirect_to request.referer, notice: "個数を選択してください"
      end
    else
      @cart_item = CartItem.new(cart_item_update_params)
      @cart_item.customer_id = current_customer.id
      if @cart_item.save
        redirect_to cart_items_path, notice: "#{@cart_item.item.name}をカートに追加しました。"
      else
        redirect_to request.referer, notice: "個数を選択してください"
      end
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_update_params)
      redirect_to request.referer, notice: "カート内の商品(#{@cart_item.item.name})の数量を変更しました。"
    else
      @cart_items = current_customer.cart_items
      @total_payment_no_shipfee = CartItem.total_payment_no_shipfee(@cart_items)
      render "index"
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.destroy
      redirect_to request.referer, notice: "カート内の商品を1件(#{cart_item.item.name})削除しました。"
    else
      @cart_items = current_customer.cart_items
      @total_payment_no_shipfee = CartItem.total_payment_no_shipfee(@cart_items)
      render "index"
    end
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      cart_item.destroy
    end
    redirect_to request.referer, notice: "カート内の商品は全て削除されました。"
  end

  private
  def cart_item_update_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end


end
