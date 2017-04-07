class ApplicationController < ActionController::API
  #devise es celoso parametros fuertes 'strong params' adicionalmente vamos a pasar mas llaves 
  #sainitizer no deja modificar 
  
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    if resource_class == Retailer 
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :description, :email, :phoneNumber, :photo, :location])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :description, :phoneNumber, :photo])
    elsif resource_class == Distributor
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phoneNumber, :photo, :email, :location])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phoneNumber, :photo])
    end
  end
end