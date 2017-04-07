module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
  
    def new
      create
    end
    def create
      super
    end
  end
end