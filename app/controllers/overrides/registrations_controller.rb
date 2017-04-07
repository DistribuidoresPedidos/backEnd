module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
  
    def new
    end
    def create
      super
    end
  end
end