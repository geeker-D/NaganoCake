class Admin::OrderDetailsController < Admin::ApplicationController

  def update
    @order = Order.find(params[:order_id])
    @order_detail = OrderDetail.find(params[:id])
    @order_details = @order.order_details
    @order_detail.update(order_detail_params)
    flash[:notice] = "更新しました"
    # 製作ステータスが製作中にすると、注文ステータスも製作中へ変更する。
    if @order_detail.product_status == "making"
      @order.update(status: "making")
      redirect_back(fallback_location: root_path)
    elsif
      # 注文詳細のレコードをカウントして、製作ステータスの製作完了の数と同じなら注文ステータスの表示を発送準備中へ変更する。
      @order_details.count == @order_details.where(product_status: "complete").count
      @order.update(status: "prepare_shipping")
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:product_status)
  end
end
