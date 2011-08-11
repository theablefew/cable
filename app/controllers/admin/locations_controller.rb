class Admin::LocationsController < AdminController
  
  respond_to :html, :xml, :json
  cache_sweeper :cable_sweeper
  # GET /banners/new
  # GET /banners/new.xml
  def new
    @location = Location.new
    respond_with(:admin , @location)
  end

  # POST /banners
  # POST /banners.xml
  def create
    @location = Location.new(params[:location])
    if @location.save
      Location.rebuild!
    end
    
    respond_with(:admin,@location) do |format|
      format.html { redirect_to admin_menus_path }
    end
  end

  # PUT /banners/1
  # PUT /banners/1.xml
  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(params[:location])
      Location.rebuild!
    end
    respond_with(:admin,@location) do |format|
      format.html { redirect_to admin_menus_path }
    end
  end

  # DELETE /banners/1
  # DELETE /banners/1.xml
  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    Location.rebuild!
    redirect_to(admin_menus_path, :notice => "Successfully destroyed") and return
  end

end