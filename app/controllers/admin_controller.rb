class AdminController < Cable::CableAdminController
  layout proc{ |c| c.request.xhr? ? false : "admin" }  
  def index
  end
  
  protected
    # Add protected methods here
end
