module AdminHelper
  
  def admin_user_login
      content_for( :admin_login ){ render 'admin/admin_user_login' }
  end
  
end
