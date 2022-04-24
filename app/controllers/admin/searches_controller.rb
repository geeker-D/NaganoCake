class Admin::SearchesController < Admin::ApplicationController

  skip_before_action :authenticate_admin!, only: [:search_item]

  def search_item
    @item_name = params[:search_text]
    @genres = Genre.page(params[:page])
    @search_result = Item.search_item_fnc(@item_name)
  end

end
