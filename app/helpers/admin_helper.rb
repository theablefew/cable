module AdminHelper
  include Cable::Helpers::KaminariHelper
  def admin_user_login
      content_for( :admin_login ){ render 'admin/admin_user_login' }
  end
  
  def single_column?
    return @single_column if @single_column == true
    !content_for?(:sidebar) and !content_for?(:admin_sub_navigation)
  end
  
end
