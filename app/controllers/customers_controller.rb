class CustomersController < ApplicationController

 
  def edit
   @customer = current_customer
  end
  
  def show
   @customer = current_customer
  end
  
  def update
   @customer = current_customer
   if @customer.update(customer_params)
    flash[:success] = "登録情報を変更しました。"
    redirect_to customers_path
   else
    render 'edit'
   end
  end
  
  def unsubscribe
    @customer = current_customer
  end

  
  
  def withdraw
    @customer = current_customer
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  private
   def customer_params
   params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_customer_status)
   end
end
