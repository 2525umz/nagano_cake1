class Public::AddressesController < ApplicationController
  def index
    @addresse = Addresse.new
    @addresses = current_customer
  end
  
  def edit
    @addresses = addressess.find(params[:id])
  end

  def create
     @addresse = Addresse.new(addresses_params)
     @addresse.customer_id = current_customer.id
     if @addresse.save
     redirect_to addresses_path
     else
     @addresse = Addresses.new
     @addresses = current_customer.addresses
     render 'index'
     end
  end
  
  
  def update
  end
  
  def destroy
  end
   private
   def addresses_params
   params.require(:addresse).permit(:customer_id, :name, :postal_code, :address)
   end
end
