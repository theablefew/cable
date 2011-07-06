class MainController < ApplicationController
  
  ## Cable::Helpers::CableControllerHelpers defines find_by_url method. Overwrite to make customized changes.
  # def find_by_url
  #   @location = Location.find_by_marketable_url( params[:url] ) || Location.find_by_url( "/#{params[:url]}" )
  #   unless @location.nil?
  #     @resource = @location.resource
  #     @page_title =  (@location.title.nil?) ? "" : @location.title
  #     send(@location.special_action) unless @location.special_action.blank?
  #     render :action => :show
  #   else
  #     redirect_to "/"
  #   end
  # end
  
  include Cable::Helpers::CableControllerHelpers
  
  def index
    #default action
  end
end