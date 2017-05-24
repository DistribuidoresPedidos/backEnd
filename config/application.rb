require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"
require 'fog/aws'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
# config/application.rb
require 'rack/throttle'

module DealersApi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    #HTML Requests per minute
    config.middleware.use Rack::Throttle::Minute, :max => 300
    #HTML Requests per hour
    config.middleware.use Rack::Throttle::Hourly,   :max => 2000
    #HTML daily Requests
    config.middleware.use Rack::Throttle::Daily, :max => 20000
    #HTML Interval between Requests
    #config.middleware.use Rack::Throttle::Interval, :min => 3.0

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*',
          :headers => :any,
          :expose =>   ['access-token', 'expiry', 'token-type', 'uid', 'client'],
          :methods => [:get,:post,:options,:delete,:put,:patch,:head]
      end
    end
    config.middleware.use Rack::Deflater
    config.autoload_paths += %W(#{config.root}/lib)
    
    #config.middleware.use ActionDispatch::Cookies
    #config.middleware.use ActionDispatch::Session::CookieStore
  end

end
