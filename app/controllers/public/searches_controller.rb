class Public::SearchesController < Public::ApplicationController
  def search_item
  end

  def search_genre
    # binding.pry
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @items = Item.where(genre_id: @genre.id, is_active: true).page(params[:page]).per(8)
  end
end
