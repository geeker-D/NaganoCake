class Admin::OrdersController < Admin::ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.find(params[:id])
    @order_details = @order.order_details
  end

  def update
      @order = Order.find(params[:id])
      @order_details = @order.order_details
      @order.update(order_params)
    if @order.status == "confirm_deposit"
      @order_details.update_all(product_status: "wait_making")
      redirect_to admin_order_path(@order)
    else
      redirect_to admin_order_path(@order)
    end

  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
