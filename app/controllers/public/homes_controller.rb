class Public::HomesController < Public::ApplicationController

  def top
    @items = Item.get_items_sort_of_CreateDate(4)
    @genres = Genre.page(params[:page])
  end

  def about
  end

end
