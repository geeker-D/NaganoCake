class Public::ItemsController < Public::ApplicationController
  def index
    @items = Item.page(params[:page])
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
  
  private
  def item_params
    params.require(:item).permit(:name, :summary, :price_non_tax, :is_active, :image)  
  end
end
