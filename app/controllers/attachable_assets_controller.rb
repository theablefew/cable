class AttachableAssetsController < ApplicationController

  def index
    @attachable_assets = AttachableAsset.find(:all)

    respond_to do |format|
      format.html
      format.json { render :json => @attachable_assets.to_json }
    end
  end

  def show
    @attachable_asset = AttachableAsset.find(params[:id])

    respond_to do |format|
      format.html { render :action => "show" }
      format.json { render :json => @attachable_asset.to_json }
    end
  end

  def new
    @attachable_asset = AttachableAsset.new
    respond_to do |format|
      format.html { render :action => "new" }
    end
  end

  def edit
    @attachable_asset = AttachableAsset.find(params[:id])

    respond_to do |format|
      format.html { render :action => "edit" }
    end
  end

  def create
    @attachable_asset = AttachableAsset.new(params[:attachable_asset])

    respond_to do |format|
      if @attachable_asset.save
        format.html { redirect_to(@attachable_asset)}
        format.json { render :json => @attachable_asset.to_json }
      else
        format.html { render :action => "new" }
        format.json { render :json => { :errors => @attachable_asset.errors }.to_json }
      end
    end
  end

  def update
    @attachable_asset = AttachableAsset.find(params[:id])

    respond_to do |format|
      if @attachable_asset.update_attributes(params[:attachable_asset])
        format.html { redirect_to(@attachable_asset)}
        format.json { render :json => @attachable_asset.to_json }
      else
        format.html { render :action => "new" }
        format.json { render :json => { :errors => @attachable_asset.errors }.to_json }
      end
    end
  end

  def delete
    @attachable_asset = AttachableAsset.find(params[:id])
    @attachable_asset.destroy
    
    respond_to do |format|
      format.html { redirect_to attachable_assets_path }
      format.json { render :json => { :message => "OK" }.to_json }
    end
  end

  def required_params_present?
    if !params[:attachable_id]
      raise AttachableException.new("Missing required parameters attachable_id")
    elsif !params[:attachable_type]
      raise AttachableException.new("Missing required parameters attachable_type")
    end
  end
end
