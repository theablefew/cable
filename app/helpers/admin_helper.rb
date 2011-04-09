module AdminHelper
  
  def admin_user_login
      content_for( :admin_login ){ render 'admin/admin_user_login' }
  end
  
  def single_column?
    !content_for?(:sidebar) and render_navigation(:level => 2..5, :context => :admin).nil?
  end
  
end
