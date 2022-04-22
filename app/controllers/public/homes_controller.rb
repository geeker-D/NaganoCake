class Public::HomesController < Public::ApplicationController

  def top
    @items = Item.page(params[:page])
    @genres = Genre.page(params[:page])
  end

  def about
  end

end
