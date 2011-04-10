class Admin::<%= class_name %>sController < AdminController
  respond_to :html, :xml, :json  
  # GET /pages
  # GET /pages.xml
  def index
    @<%= singular_table_name %>s = <%= class_name %>.roots
    @admin_layout = "single"    
    <%= class_name %>.rebuild!
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @<%= singular_table_name %>s }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @<%= singular_table_name %> = <%= class_name %>.where( :id => params[:id]).first
    @<%= singular_table_name %>s = <%= class_name %>.roots
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @<%= singular_table_name %> }
      format.js { render :partial => "admin/<%= singular_table_name %>s/parents" } 
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @resource_types = Cable.resource_types.collect{|resource| ["#{resource.name}","#{resource.name.pluralize}"]}
    @resources = @resource_types.first[0].classify.constantize.find(:all).sort{|x,y| x.title <=> y.title}
    
    @<%= singular_table_name %> = <%= class_name %>.new
    if params[:parent_id] && params[:parent_id] != "0"
      @parent = <%= class_name %>.find(params[:parent_id])
      @<%= singular_table_name %>.parent_id = @parent.id
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @<%= singular_table_name %> }
    end
  end

  # GET /pages/1/edit
  def edit
    @<%= singular_table_name %> = <%= class_name %>.includes(:cable_<%= singular_table_name %>able).where( :id => params[:id]).first
    @resource_types = Cable.resource_types.collect{|resource| ["#{resource.name}","#{resource.name.pluralize}"]}
    @resources = @<%= singular_table_name %>.cable_<%= singular_table_name %>able_type.classify.constantize.find(:all).sort{|x,y| x.title <=> y.title}
  end
  
  # POST /pages
  # POST /pages.xml
  def create
    
    @<%= singular_table_name %> = <%= class_name %>.new(params[:<%= singular_table_name %>])

    respond_to do |format|
      if @<%= singular_table_name %>.save
        <%= class_name %>.rebuild!
        format.html { redirect_to([:admin ,@<%= singular_table_name %>], :notice => '<%= class_name %> was successfully created.') }
        format.xml  { render :xml => @<%= singular_table_name %>, :status => :created, :location => @<%= singular_table_name %> }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @<%= singular_table_name %>.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @<%= singular_table_name %> = <%= class_name %>.includes(:cable_<%= singular_table_name %>able).where( :id => params[:id]).first
    
    params[:<%= singular_table_name %>][:tree_id] = <%= class_name %>.find(params[:<%= singular_table_name %>][:parent_id]).tree_id unless params[:<%= singular_table_name %>][:parent_id].blank?
    
      respond_to do |format|
      if @<%= singular_table_name %>.update_attributes(params[:<%= singular_table_name %>])
        <%= class_name %>.rebuild!
        format.html { redirect_to([:admin, @<%= singular_table_name %>], :notice => '<%= class_name %> was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @<%= singular_table_name %>.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @<%= singular_table_name %> = <%= class_name %>.where( :id => params[:id]).first
    @<%= singular_table_name %>.destroy
    
    respond_to do |format|
      format.html { redirect_to(admin_<%= singular_table_name %>s_url) }
      format.xml  { head :ok }
    end
  end
  
  def sort
    new_list = params[:ul]
    previous = nil
    new_list.each_with_index do |array, index|
      moved_item_id = array[1][:id].split(/<%= singular_table_name %>_/)
      @current_<%= singular_table_name %> = <%= class_name %>.find_by_id(moved_item_id)
      unless previous.nil?
        @previous_item = <%= class_name %>.find_by_id(previous)
        @current_<%= singular_table_name %>.move_to_right_of(@previous_item)
      else
        @current_<%= singular_table_name %>.move_to_root
      end
      unless array[1][:children].blank?
        parse_children(array[1], @current_<%= singular_table_name %>)
      end
      previous = moved_item_id
    end
    <%= class_name %>.rebuild!
    render :nothing => true
  end
  
  def parse_children(mynode, <%= singular_table_name %>)
    for child in mynode[:children]
      child_id = child[1][:id].split(/<%= singular_table_name %>_/)
      child_<%= singular_table_name %> = <%= class_name %>.find_by_id(child_id)
      child_<%= singular_table_name %>.move_to_child_of(<%= singular_table_name %>)
      unless child[1][:children].blank?
        parse_children(child[1], child_<%= singular_table_name %>)
      end
    end
  end
  
  def resources
    resource_type = params[:resource]
    @resources = "#{resource_type}".classify.constantize.find(:all).sort{|x,y| x.title <=> y.title}
    respond_to do |format|
      format.js
    end
  end
end