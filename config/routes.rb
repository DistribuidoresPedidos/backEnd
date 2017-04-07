Rails.application.routes.draw do
#Retailer dont has routes for products , and retailer has routes for offered_products
  
  scope '/api' do
    scope '/v1' do
       mount_devise_token_auth_for 'Distributor', at: 'distri_path'
       as :distributor do
        resources :distributors, only: [:index, :show] do
          get 'orders_by_arrival_date', to: 'orders#orders_by_arrival_date'
          get 'orders_by_exit_date', to: 'orders#orders_by_exit_date'
          get 'offered_products_by_categories', to: 'offered_products#offered_products_by_categories'
          get 'products_by_categories', to: 'products#products_by_categories'
          resources :orders, except: [:create]
          resources :products 
          resources :offered_products
          resources :routes 
          resources :order_products
        end
    #  end
   # end

      mount_devise_token_auth_for 'Retailer', at: 'retai_path'
      as :retailer do
        resources :retailers, only: [:index, :show] do
          get 'orders_by_arrival_date', to: 'orders#orders_by_arrival_date'
          get 'orders_by_exit_date', to: 'orders#orders_by_exit_date'
          get 'offered_products_by_categories', to: 'offered_products#offered_products_by_categories'
          get 'suggest_to_retailer', to: 'offered_products#suggest_to_retailer'
          get 'offered_products_by_retailer', to: 'offered_products#offered_products_by_param_retailer'
          get 'products_by_categories', to: 'products#products_by_categories'
          get 'distributors_by_retailer', to: 'distributors#distributors_by_retailer'
          resources :orders
          resources :offered_products
          get 'order_product_by_retailer', to: 'order_products#order_product_by_retailer' 
          resources :offered_products, except: [:create, :update, :destroy]
        end
      end
 
  resources :routes do  
    resources :orders 
    resources :coordinates 
  end  
       
  resources :offered_products do  
    get 'coordinate_by_offered_product', to: 'coordinates#coordinate_by_offered_product'  
  end 

      resources :orders do
        resources :comments
      end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    end
  end
end