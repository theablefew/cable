module Cable
  module CableControllerHelpers
    # unloadable
    
    def self.included( base )
      # base.send :extend, ClassMethods
      puts "CABLE CONTROLLER!!! #{base.inspect}"
      base.send :include, InstanceMethods
    end
    
    module InstanceMethods
      def find_by_url
        puts "#{Menu.inspect}"
        @menu = Menu.find_by_marketable_url( params[:url] ) || Menu.find_by_url( "/#{params[:url]}" )
        unless @menu.nil?
          @resource = @menu.resource
          @page_title =  (@menu.nil?) ? "" : @menu.title
          send(@menu.special_action) unless @menu.special_action.blank?
          render :action => :show
        else
          redirect_to "/"
        end
      end
    end
    
  end
end