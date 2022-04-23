class Admin::SearchesController < Admin::ApplicationController
  def search_item
    @item_name = params[:search_text]
    @genres = Genre.page(params[:page])
    @search_result = Item.search_item_fnc(@item_name)
  end
end
