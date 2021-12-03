Rails.application.routes.draw do
  
  get 'customers/edit'
  get 'customers/my_page' => 'customers#show', as: 'customers'
  put 'withdraw/:customer' => 'customers#withdraw', as: 'withdrawcustomer'
  patch 'customers' => 'customers#withdraw', as: 'withdraw'
  resources :customers, only:[:update]
 devise_for :customers,skip: [:passwords,], controllers: {
  registrations: "customer/registrations",
  sessions: 'customer/sessions'
  }

  devise_for :admin
  namespace :admin do
    root to: 'homes#top'
    resources :genres, only:[:index, :edit, :create, :update]
    resources :items, only:[:index, :new, :create, :show, :edit, :update]
    resources :customers, only:[:index, :edit, :show, :update]
    resources :orders, only:[:show, :update]
    resources :order_details, only:[:update]
  end
  
  scope module: :public do
    root to: 'homes#top'
    delete :cart_items, to: 'cart_items#destroy_all'
    post :orders_new,  to: 'orders#confirm'
    get 'about' => "homes#about"
    resources :items, only:[:index, :show]
    resources :cart_items, only:[:index, :update, :destroy, :destroy_all, :create]
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete' => 'orders#complete'
    post 'orders' => 'orders#create'
    resources :orders, only:[:index, :new, :create, :show]
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
  end
end