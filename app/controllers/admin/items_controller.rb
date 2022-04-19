class Admin::ItemsController < Admin::ApplicationController

  skip_before_action :authenticate_admin!, only: [:index, :show]

  def index
  end

  def show
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
