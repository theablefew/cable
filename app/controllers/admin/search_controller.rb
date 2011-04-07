class Admin::SearchController < AdminController
  include Admin::SearchControllerHelper
  respond_to :js, :html
  
  def index
    @admin_layout = "single"
    @results =  ThinkingSphinx.search params[:term], :match_mode => :extended, :star => true
    respond_to do |format|
      format.json { render request.format.to_sym => to_json_for_autocomplete( @results) }
      format.html { redirect_to url_for([:admin, @results.first]) if @results.length == 1 }
    end
  end
  

  
end