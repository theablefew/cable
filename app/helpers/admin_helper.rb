module AdminHelper
  
  def app_name
    Rails.application.class.parent.name.underscore.titleize
  end
  
end
