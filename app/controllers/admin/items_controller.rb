class Admin::ItemsController < Admin::ApplicationController

  skip_before_action :authenticate_admin!, only: [:index, :show]

  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    if @item.save
       redirect_to admin_item_path(@item.id)
    else
      @genres = Genre.all
      render :new
    end
  end

  def update
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :summary, :price_non_tax, :genre_id, :is_active)
  end

end
