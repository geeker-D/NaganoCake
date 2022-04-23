class Admin::OrderDetailsController < Admin::ApplicationController

  def update
    @order = Order.find(params[:order_id])
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    redirect_back(fallback_location: root_path)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:product_status)
  end
end
