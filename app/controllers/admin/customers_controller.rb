class Admin::CustomersController < Admin::ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
  end

  def update
  end

  def index_order
  end

end
