module Cable
  class CableAdminController < ApplicationController
    unloadable


    def use_single_column
      @single_column = true
    end
    
    protected
      # Add protected methods here
  end
end