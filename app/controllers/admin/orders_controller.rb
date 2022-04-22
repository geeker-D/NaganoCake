class Admin::OrdersController < Admin::ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @orders = Order.all
    @order_detail = OrderDetail.find(params[:id])
  end

  def update
      @order = Order.find(params[:id])
    if@order.update(order_params)
      redirect_back(fallback_location: root_path)
    else
      render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
