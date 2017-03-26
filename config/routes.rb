Rails.application.routes.draw do
  mount_devise_token_auth_for 'Distributor', at: 'distri_path'

  mount_devise_token_auth_for 'Retailer', at: 'retai_path'
  as :retailer do
    # Define routes for Retailer within this block.
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
