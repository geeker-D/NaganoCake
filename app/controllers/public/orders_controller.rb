class Public::OrdersController < Public::ApplicationController
  def index
  end

  def show
  end

  def new
    @order = Order.new
    @current_customer_post = current_customer.post_code
    @current_customer_address = current_customer.address
    @current_customer_to_name = "#{current_customer.last_name}" + "#{current_customer.first_name}"

  end

  def create
  end

  def order_preconfirm

  end

  def complete
  end
end
