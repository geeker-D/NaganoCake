class Public::CartItemsController < Public::ApplicationController
  def index
    # binding.pry
    customer = current_customer
    @cart_items = customer.cart_items
    #合計金額(送料なし、税込み)
    @total_payment_no_shipfee = 0
    @cart_items.each do |cart_item|
      @total_payment_no_shipfee += (cart_item.item.price_non_tax * 1.1).floor * cart_item.amount
    end

  end

  def create
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end
end
