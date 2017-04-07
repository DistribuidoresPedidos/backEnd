Rails.application.routes.draw do
#Retailer dont has routes for products , and retailer has routes for offered_products
  
  scope '/api' do
    scope '/v1' do
       
        resources :distributors, only: [:index, :show] do
          get 'orders_by_arrival_date', to: 'orders#orders_by_arrival_date'
          get 'orders_by_exit_date', to: 'orders#orders_by_exit_date'
          get 'offered_products_by_categories', to: 'offered_products#offered_products_by_categories'
          get 'products_by_categories', to: 'products#products_by_categories'
          resources :orders, except: [:create]
          resources :products 
          resources :offered_products
        end
      
   # end

      
        resources :retailers, only: [:index, :show] do
          get 'orders_by_arrival_date', to: 'orders#orders_by_arrival_date'
          get 'orders_by_exit_date', to: 'orders#orders_by_exit_date'
          get 'offered_products_by_categories', to: 'offered_products#offered_products_by_categories'
          get 'suggest_to_retailer', to: 'offered_products#suggest_to_retailer'
          get 'offered_products_by_retailer', to: 'offered_products#offered_products_by_param_retailer'
          get 'products_by_categories', to: 'products#products_by_categories'
          get 'distributors_by_retailer', to: 'distributors#distributors_by_retailer'
          resources :orders, except: [:create]
          resources :offered_products, except: [:create, :update, :destroy]
        end
     
    

      resources :orders do
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