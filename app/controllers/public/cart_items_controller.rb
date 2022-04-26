class Public::CartItemsController < Public::ApplicationController

  def index
    @cart_items = current_customer.cart_items
    @total_payment_no_shipfee = CartItem.total_payment_no_shipfee(@cart_items)
  end

  def create
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]) # カート内にアイテムが存在した時の処理
      @cart_item_now = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]) # 同じアイテムを探す
      @cart_item_now.amount += params[:cart_item][:amount].to_i # カートにある数量と選択した数量を足す
      if @cart_item_now.amount <= 10 && params[:cart_item][:amount].to_i != 0 # カート内のアイテムが10個以内かつ数量を選択した時の処理
        @cart_item_now.update(amount: @cart_item_now.amount) # アイテムの数量を更新
        redirect_to cart_items_path, notice: "#{@cart_item_now.item.name}をカートに追加しました。"
      elsif @cart_item_now.amount > 10 # カート内のアイテムが10個より多い時の処理
        redirect_to request.referer, notice: "#{@cart_item_now.item.name}の合計が10個以内になるように選択してください"
      else　# アイテム数量を選択していない時の処理
        redirect_to request.referer, notice: "個数を選択してください"
      end
    else # カート内にアイテムが存在しない時の処理
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
    if (params[:cart_item][:amount]).to_i <= 10
      if @cart_item.update(cart_item_update_params)
        redirect_to request.referer, notice: "カート内の商品(#{@cart_item.item.name})の数量を変更しました。"
      else
        redirect_to request.referer, notice: "数量の更新が反映されませんでした。再度お試しください。"
      end
    else
      redirect_to request.referer, notice: "1商品あたりの数量は10個以内でご指定ください。"
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
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end


end
