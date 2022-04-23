class Public::SearchesController < Public::ApplicationController

  skip_before_action :authenticate_customer!, only: [:search_item, :search_genre]

  def search_item
    @item_name = params[:search_text]
    @genres = Genre.page(params[:page])
    @search_result = Item.search_item_fnc(@item_name)
  end

  def search_genre
  end
end
