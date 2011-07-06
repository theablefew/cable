module MainHelper
  def request_is_missing_static_resource?
    !(/([^\s]+(\.(?i)(css|js|jpg|png|gif|bmp))$)/.match(request.path).nil?)
  end
end
