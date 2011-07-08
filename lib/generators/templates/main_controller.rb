class MainController < ApplicationController
  
  include Cable::Helpers::CableControllerHelpers
  include Cable::Helpers::UrlMaskHelper
  
  ## Cable::Helpers::CableControllerHelpers defines find_by_url method. Overwrite to make customized changes.
  # def find_by_url
  #   @location = Location.find_by_marketable_url( params[:url] ) || Location.find_by_url( request.path )
  #   unless @location.nil?
  #     @resource = @location.resource
  #     @page_title =  (@location.title.nil?) ? "" : @location.title
  #     send(@location.special_action) unless @location.special_action.blank?
  #     render :action => :show
  #   else
  #     redirect_to "/"
  #     logger.info "[Cable] No location found. Redirecting".color(:yellow)
  #   end
  # end
  
  # before_filter :find_by_url_mask
  # def find_by_url_mask
  # 
  #   masked_resources = UrlMask.find_resource_by_url( request.path )
  #   logger.info "#{masked_resources}".color(:yellow)
  #   prepare_variables_for_masked_resources( masked_resources ) unless masked_resources.nil?
  # 
  # end

  def index
    #default action
  end
end