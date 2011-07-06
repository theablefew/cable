require 'rainbow'
module Cable
  module Helpers
    module CableControllerHelpers
    # unloadable
    
      def self.included( base )
        # base.send :extend, ClassMethods
        # puts "CABLE CONTROLLER!!! #{base.inspect}"
        base.send :include, InstanceMethods
      end
    
      module InstanceMethods
        def find_by_url
          @location = Location.find_by_marketable_url( params[:url] ) || Location.find_by_url( request.path )
          unless @location.nil?
            @resource = @location.resource
            @page_title =  (@location.title.nil?) ? "" : @location.title
            send(@location.special_action) unless @location.special_action.blank?
            render :action => :show
          else
            logger.info "[Cable] No location found. Redirecting to root.".color(:yellow)
            redirect_to "/"
          end
        end
      end
   end 
  end
end