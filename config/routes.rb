Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :distributors do
        resources :products 
        resources :offered_products
      end
    end
  end



  mount_devise_token_auth_for 'Distributor', at: 'distri_path'
  as :distributor do

  end
  mount_devise_token_auth_for 'Retailer', at: 'retai_path'
  as :retailer do
    resources :retailers do
      resources :orders
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
