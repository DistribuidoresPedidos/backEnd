Rails.application.routes.draw do
#Retailer dont has routes for products , and retailer has routes for offered_products
  
  scope '/api' do
    scope '/v1' do
       
        resources :distributors, only: [:index, :show] do
          get 'orders_by_arrival_date', to: 'orders#orders_by_arrival_date'
          get 'orders_by_exit_date', to: 'orders#orders_by_exit_date'
          get 'suggest_retailers', to: 'retailers#suggest_to_distributor_by_category'
          get 'categories_by_distributor', to: 'products#categories_by_distributor'
          resources :orders, except: [:create]
          resources :products 
          resources :offered_products
          resources :routes 
          resources :order_products
        end
      
   # end

      
        resources :retailers, only: [:index, :show] do
          collection do
            get 'retailer_by_categories', to: 'retailers#retailer_by_category_products'
          end

          get 'orders_by_arrival_date', to: 'orders#orders_by_arrival_date'
          get 'orders_by_exit_date', to: 'orders#orders_by_exit_date'
          
          get 'suggest_to_retailer', to: 'offered_products#suggest_to_retailer'
          get 'offered_products_by_retailer', to: 'offered_products#offered_products_by_param_retailer'
          get 'offered_products_by_param_retailer_match', to: 'offered_products#offered_products_by_param_retailer_match'          
          get 'offered_products_close', to: 'offered_products#offered_products_close_to_retailer'

          get 'distributors_by_retailer', to: 'distributors#distributors_by_retailer'
          get 'order_product_by_retailer', to: 'order_products#order_product_by_retailer' 
          get 'categories_by_retailer', to: 'products#categories_by_retailer'
          resources :orders, except: [:create]
          resources :offered_products, except: [:create, :update, :destroy]
        end
     
 
      resources :routes do  
        resources :orders 
        resources :coordinates 
      end  
          
      resources :offered_products do
        collection do
          get 'offered_products_by_categories', to: 'offered_products#offered_products_by_categories'  
          get 'offered_products_most_selled', to: 'offered_products#offered_products_most_selled'
        end
        get 'coordinate_by_offered_product', to: 'coordinates#coordinate_by_offered_product'  
      end 
      
      resources :products do
        collection do
          get 'products_by_ids', to: 'products#products_by_ids'
          get 'products_by_categories', to: 'products#products_by_categories'
        end
    end
      
      
      resources :orders do
        collection do
          post 'make_order', to: 'orders#make_order'
        end
        get 'order_products', to: 'order_products#order_products_by_order'
        resources :comments
      end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    end
  end
  mount_devise_token_auth_for 'Distributor', at: 'api/v1/distri_path', skip: [:omniauth_callbacks] , controllers:{
    registrations: 'overrides/registrations'
  }
       
  mount_devise_token_auth_for 'Retailer', at: 'api/v1/retai_path',  skip: [:omniauth_callbacks] , controllers:{
    registrations: 'overrides/registrations'
  }
end