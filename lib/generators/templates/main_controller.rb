class MainController < ApplicationController
  
  ## Cable::Helpers::CableControllerHelpers defines find_by_url method. Overwrite to make customized changes.
  # def find_by_url
  #   unless request_is_missing_static_resource?
  #     @location = Location.includes(:menus).find_by_marketable_url( params[:url] ) || Location.includes(:menus).find_by_url( request.path )
  #     unless @location.nil?
  #       @resource = @location.resource
  #       @page_title =  (@location.title.nil?) ? "" : @location.title
  #       send(@location.special_action) unless @location.special_action.blank?
  #       @continue_execution = send(@location.special_action) unless @location.special_action.blank?
  #       render :action => :show, :layout => "internal" if @continue_execution || @continue_execution.nil?
  #     else
  #       logger.warn "[Cable::MissingLocation] No location found for /#{params[:url]}. Redirecting to root.".color(:red)
  #       redirect_to "/" and return false
  #     end
  #   else
  #     render :nothing => true, :status => 403
  #   end
  # end
  
  # before_filter :find_by_url_mask
  # def find_by_url_mask
  # 
  #   masked_resources = UrlMask.find_resource_by_url( request.path )
  #   prepare_variables_for_masked_resources( masked_resources ) unless masked_resources.empty?
  # 
  # end

  def index
    #default action
  end
end