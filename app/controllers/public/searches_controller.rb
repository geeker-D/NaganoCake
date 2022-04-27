class Public::SearchesController < Public::ApplicationController

  skip_before_action :authenticate_customer!, only: [:search_item, :search_genre]

  def search_item
    @item_name = params[:search_text]
    @genres = Genre.page(params[:page])
    @search_result = Item.search_item_fnc(@item_name)
  end

  def search_genre
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @items = Item.where(genre_id: @genre.id, is_active: true).page(params[:page]).per(8)
  end
end
