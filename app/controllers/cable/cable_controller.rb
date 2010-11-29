class Cable::CableController < ApplicationController
  unloadable

  def show
    # @menu = Menu.find_by_marketable_url( params[:id] )
    # @menu = Menu.where( :id => params[:id]).first
    # @resource = @menu.resource
    # unless @menu.special_action.nil?
    #   send(@menu.special_action)
    # end
  end
  
  def find_by_url
    @menu = CableEngine::Menu.find_by_marketable_url( params[:url] ) || CableEngine::Menu.find_by_url( "/#{params[:url]}" )
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