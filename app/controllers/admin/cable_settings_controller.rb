class Admin::CableSettingsController < AdminController
  
  def index
    @cable_setting = Cable::Setting.last || Cable::Setting.create(:site_title => Rails.application.class.parent.name.underscore.titleize )
  end
  
  def edit
    @cable_setting = Cable::Setting.last
  end  

  def update  
    @cable_setting = Cable::Setting.where( :id => params[:id]).first  
    if @cable_setting.update_attributes(params[:cable_setting])  
      flash[:notice] = "Successfully updated cable settings."  
      redirect_to admin_cable_settings_path
    else  
      render :action => 'edit'
    end  
  end
end