class AdminController < Cable::CableAdminController
  layout proc{ |c| c.request.xhr? ? false : "admin" }  
  #uses_tiny_mce :options => {:editor_selector => "html_editor"}
  def index
  end
  
  protected

    # Add protected methods here
end
