class Admin::ItemsController < Admin::ApplicationController

  skip_before_action :authenticate_admin!, only: [:index, :show]

  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end
end
