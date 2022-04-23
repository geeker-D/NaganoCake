class Public::HomesController < Public::ApplicationController

  def top
    @items = Item.order(created_at: :desc).limit(4)
    @genres = Genre.page(params[:page])
  end

  def about
  end

end
