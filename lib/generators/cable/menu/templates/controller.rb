class Admin::<%= class_name %>sController < AdminController
  # GET /pages
  # GET /pages.xml
  def index
    @<%= plural_table_name %> = [<%= class_name %>.roots.first]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @<%= plural_table_name %> }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @<%= singular_table_name %> = <%= class_name %>.where( :id => params[:id]).first

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @<%= singular_table_name %> }
      format.js { render :update do |page|
                     page << "$('#dialog').dialog('close');"
                   end
                }
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @<%= singular_table_name %> = <%= class_name %>.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @<%= singular_table_name %> }
    end
  end

  # GET /pages/1/edit
  def edit
    @<%= singular_table_name %> = <%= class_name %>.where( :id => params[:id]).first
  end
  
  def edit_remote
    @<%= singular_table_name %> = <%= class_name %>.where( :id => params[:id]).first
    render :update do |page|
      page << "$('#dialog').html('#{escape_javascript(render(:partial => 'admin/menus/edit_remote'))}')"
      # page.replace_html "#dialog" , :partial => 'admin/menus/edit_remote'
      page << "$('#dialog').dialog({width:700,modal:true});"
    end
  end
  
  def edit_tree
    @<%= plural_table_name %> = <%= class_name %>.where( :id => params[:id] )
  end
  

  # POST /pages
  # POST /pages.xml
  def create
    @<%= singular_table_name %> = <%= class_name %>.new(params[:page])

    respond_to do |format|
      if @<%= singular_table_name %>.save
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
    @<%= singular_table_name %> = <%= class_name %>.where( :id => params[:id]).first
      respond_to do |format|
      if @<%= singular_table_name %>.update_attributes(params[:menu])
        format.html { redirect_to([:admin, @<%= singular_table_name %>], :notice => '<%= class_name %> was successfully updated.') }
        format.xml  { head :ok }
        # <%= class_name %>.rebuild!
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
  
  def update_tree
    
    @<%= singular_table_name %> = <%= class_name %>.where( :id => params[:id]).first
    sql = ""
    conn = ActiveRecord::Base.connection
    conn.execute "SET autocommit=0";
    conn.begin_db_transaction
    
    if params[:parent].to_i == 0
      logger.debug("----------------------")
      sql = "UPDATE `menus` SET lft='#{params[:lft].to_i}', rgt='#{params[:rgt].to_i}' WHERE id='#{params[:id].to_i};'"      
    else
      sql = "UPDATE `menus` SET lft='#{params[:lft].to_i}', rgt='#{params[:rgt].to_i}', parent_id='#{params[:parent]}' WHERE id='#{params[:id].to_i};'"      
    end
    conn.update(sql)
    conn.commit_db_transaction
    # <%= class_name %>.rebuild!
    render :update do |page|
      page << "$('#messages_container').html('#{escape_javascript(render(:partial => 'layouts/messages'))}')"
      # page.replace_html "#messages_container" , :partial => 'layouts/messages'
      page << "$('#messages_container').fadeOut();"
    end
  end
  
  def rebuild
    <%= class_name %>.rebuild!
    flash[:notice] = "<%= class_name %> Tree Rebuilt."
    <%= class_name %>.find_by_title( "Home" ).generate_marketable_url
    redirect_to admin_menus_path
  end

  def table
    @<%= plural_table_name %> = <%= class_name %>.all
  end
end
