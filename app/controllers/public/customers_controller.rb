class Public::CustomersController < Public::ApplicationController
  def show
  end

  def edit
    @customer = current_customer
    if @customer != current_customer
      redirect_to customers_mypage_path(current_customer)
    end
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_mypage_path(current_customer), notice: "会員情報が更新されました"
    else
      render 'edit'
    end
  end

  def unsubscribe
  end

  def defection
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会処理を実行しました"
  end

  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :post_code, :address, :phone_number, :email, :is_deleted)
  end

end
