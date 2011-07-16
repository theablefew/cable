class AdminController < Cable::CableAdminController
  layout proc{ |c| c.request.xhr? ? false : "admin" }  
  uses_tiny_mce :options => {:editor_selector => "html_editor"
    # :style_formats =>"eval([{:title => 'Small', :inline => 'span', :classes => 'small'}, {:title => 'Red', :inline => 'span', :classes => 'red'}])"
  }
  def index
  end
  
  protected

    # Add protected methods here
end
