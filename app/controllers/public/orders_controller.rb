class Public::OrdersController < ApplicationController
  
 def new
   @cart_items = current_customer.cart_items
   @orders = Order.new
 end

 def confirm
   @cart_items = current_customer.cart_items
   @orders = Order.new
   @shipping_cost = 800
	  @order = Order.new(order_confirm_params)
	  @order.postal_code = current_customer.postal_code
	  @order.address = current_customer.address
	  @order.name = current_customer.last_name+current_customer.first_name
 end

 
 def complete
 end

 def create
  order = Order.new(order_params)
		order.save!
	
	 @cart_items = current_customer.cart_items
		@cart_items.each do |cart_item|
		order_detail = OrderDetail.new
		order_detail.item_id = cart_item.item_id
		order_detail.price = cart_item.item.price
		order_detail.amount = cart_item.amount	
		order_detail.order_id = order.id
		order_detail.making_status = 0
		order_detail.save
		end
		redirect_to orders_complete_path

 end

 def index
  @orders = current_customer.orders
 end
  
 def show
  @order = Order.find(params[:id])
		@order_details = @order.order_details
 end
 
 def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
 end
 
 def order_confirm_params
   params.require(:order).permit(:payment_method)
 end
end
