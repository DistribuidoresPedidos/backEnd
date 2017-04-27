module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    devise_token_auth_group :member, contains: [:retailer, :distributor]

    def create
      @resource1 = resource_class.new(sign_up_params)
      @resource1.provider ="email"

      type= @resource1.is_a?(Distributor) ? "distributor" : "retailer"
      #what kind of user
      #validation
      if resource_class.case_insensitive_keys.include?(:email)
        @resource1.email= sign_up_params[:email].try :downcase
      else
        @resource1.email= sign_up_params[:email]
      end

      # give redirect value from params priority
      @redirect_url= params[:confirm_success_url]

      #fall back to default value if provided

      @redirect_url ||= DeviseTokenAuth.default_confirm_success_url

      #success redirect url is required
      if resource_class.devise_modules.include?(:confirmable) && !@redirect_url
        return  render_create_error_missing_confirm_success_url
      end

      # if whitelist is set, validate redirect_url against whitelist
      #What is whitelist? -> http://searchexchange.techtarget.com/definition/whitelist
      if DeviseTokenAuth.redirect_whitelist
        unless DeviseTokenAuth::Url.whitelisted(@redirect_url)
          return render_create_error_redirect_url_not_allowed
        end
      end

      begin
        #override email confirmation, must be sent from controller
        resource_class.set_callback("create", :after, :send_on_create_confirmation_instructions)
        resource_class.skip_callback("create", :after, :send_on_create_confirmation_instructions)

        if @resource1.save
          yield @resource1 if block_given?
            unless @resource1.confirmed?
                #user will require email authentication
                @resource1.send_confirmation_instructions({
                  client_config: params[:config_name],
                  redirect_url: @redirect_url
                })
            else
              @client_id= SecureRandom.urlsafe_base64(nil, false)
              @token= SecureRandom.urlsafe_base64(nil, false)

              @resource1.tokens[@client_id]={
                token: @token
              }

              @resource1.valid?
              puts @resource1.errors.full_messages
              update_auth_header
            end

            render_create_success

          else
            clean_up_passwords @resource1
            render_create_error
          end

        rescue ActiveRecord::RecordNotUnique
          clean_up_passwords @resource1
          render_create_error_email_already_exists
        end
      end
    end
end
