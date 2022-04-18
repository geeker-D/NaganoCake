class Public::ItemsController < Public::ApplicationController

  skip_before_action :authenticate_customer!, only: [:index, :show]

  def index
  end

  def show
  end
end
