module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController

    def create

      field = (resource_params.keys.map(&:to_sym) & resource_class.authentication_keys).first

      @resource = nil
      if field
        q_value = resource_params[field]

        if resource_class.case_insensitive_keys.include?(field)
          q_value.downcase!
        end
        q= "#{field.to_s} = ? AND provider='email'"

        if ActiveRecord::Base.connection.adapter_name.downcase 
        end
      end
    end

    private

    def resource_params
       params.permit(*params_for_resource(:sign_in))
    end

  end
end
