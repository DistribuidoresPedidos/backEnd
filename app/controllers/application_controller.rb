class ApplicationController < ActionController::API
  #devise es celoso parametros fuertes 'strong params' adicionalmente vamos a pasar mas llaves 
  #sainitizer no deja modificar 
  
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    if resource_class == Retailer 
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :description, :email, :phoneNumber, :photo, :latitude, :longitude])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :description, :phoneNumber, :photo])
    elsif resource_class == Distributor
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phoneNumber, :photo, :email, :latitude, :longitude])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phoneNumber, :photo])
    end
  end

  def pagination_dict(collection)
  {
    current_page: collection.current_page,
    next_page: collection.next_page,
    #prev_page: collection.prev_page, # use collection.previous_page when using will_paginate
    total_pages: collection.total_pages,
    #total_count: collection.total_count
  }
  end
end