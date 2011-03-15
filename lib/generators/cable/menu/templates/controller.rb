class Admin::<%= class_name %>sController < AdminController
  respond_to :html, :xml, :json  
  # GET /pages
  # GET /pages.xml
  def index
    @<%= plural_table_name %> = <%= class_name %>.roots
    Menu.rebuild!
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @<%= plural_table_name %> }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @<%= singular_table_name %> = <%= class_name %>.where( :id => params[:id]).first
    @<%= plural_table_name %> = Menu.roots
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @<%= singular_table_name %> }
      format.js { render :partial => "admin/menus/parents" } 
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @resources = Cable.available_resources
    @<%= singular_table_name %> = <%= class_name %>.new
    if params[:parent_id] && params[:parent_id] != "0"
      @parent = Menu.find(params[:parent_id])
      @<%= singular_table_name %>.parent_id = @parent.id
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @<%= singular_table_name %> }
    end
  end

  # GET /pages/1/edit
  def edit
    @<%= singular_table_name %> = <%= class_name %>.includes(:cable_menuable).where( :id => params[:id]).first
    @resources = Cable.available_resources
  end
  
  # POST /pages
  # POST /pages.xml
  def create
    
    @<%= singular_table_name %> = <%= class_name %>.new(params[:menu])

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
    @<%= singular_table_name %> = <%= class_name %>.includes(:cable_menuable).where( :id => params[:id]).first
    
    params[:menu][:tree_id] = <%= class_name %>.find(params[:menu][:parent_id]).tree_id unless params[:menu][:parent_id].blank?
    
      respond_to do |format|
      if @<%= singular_table_name %>.update_attributes(params[:menu])
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
      format.html { redirect_to(admin_menus_url) }
      format.xml  { head :ok }
    end
  end
  
  def sort
    new_list = params[:ul]
    previous = nil
    new_list.each_with_index do |array, index|
      moved_item_id = array[1][:id].split(/menu_/)
      @current_menu = Menu.find_by_id(moved_item_id)
      unless previous.nil?
        @previous_item = Menu.find_by_id(previous)
        @current_menu.move_to_right_of(@previous_item)
      else
        @current_menu.move_to_root
      end
      unless array[1][:children].blank?
        parse_children(array[1], @current_menu)
      end
      previous = moved_item_id
    end
    Menu.rebuild!
    render :nothing => true
  end
  
  def parse_children(mynode, menu)
    for child in mynode[:children]
      child_id = child[1][:id].split(/menu_/)
      child_menu = Menu.find_by_id(child_id)
      child_menu.move_to_child_of(menu)
      unless child[1][:children].blank?
        parse_children(child[1], child_menu)
      end
    end
  end
  
  def resources
    resource_type = params[:resource]
    @resources = "#{resource_type}".classify.constantize.find(:all)
    render :update do |page|
      page << "$('#menu_cable_menuable_id_input').html('#{escape_javascript(render(:partial => 'admin/menus/resource_fields'))}')"
    end
  end
end
