class Public::CartItemsController < Public::ApplicationController
  def index
    # binding.pry
    customer = current_customer
    @cart_items = customer.cart_items

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
