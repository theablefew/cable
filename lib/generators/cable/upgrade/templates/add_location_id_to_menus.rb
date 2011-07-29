class AddLocationIdToMenus < ActiveRecord::Migration
  def self.up
    
    add_column :menus, :location_id, :integer

    sql = "INSERT INTO locations (id,locatable_id,locatable_type,parent_id,tree_id,lft,rgt,url, marketable_url,meta_description,meta_keywords,template,special_action) SELECT id,cable_menuable_id,cable_menuable_type,parent_id,tree_id,lft,rgt,url,marketable_url,meta_description,meta_keywords,template,special_action FROM menus;"
    ActiveRecord::Base.connection.execute(sql)
    ActiveRecord::Base.connection.execute("UPDATE menus set location_id = id;")
    
    Location.rebuild!
    Location.roots.each do |root| 
      root.descendants.each do |descendant| 
        descendant.tree_id = root.tree_id
        descendant.save
      end
    end
    
    # Menu.all.each do |menu|
    #   puts "Creating location for #{menu.title}." unless menu.nil? || menu.title.nil?
    #   Location.reset_callbacks( :move )
    #   Location.reset_callbacks( :save )
    #   Location.reset_callbacks( :create )
    #   Location.reset_callbacks( :validate )
    #   
    # 
    # 
    #   
    #   # location = Location.create( :locatable_id => menu[:cable_menuable_id],
    #   #                   :locatable_type => menu[:cable_menuable_type],
    #   #                   :parent_id => menu[:parent_id],
    #   #                   :tree_id => menu[:tree_id],
    #   #                   :url => menu[:url],
    #   #                   :marketable_url => menu[:marketable_url],
    #   #                   :meta_description => menu[:meta_description],
    #   #                   :meta_keywords => menu[:meta_keywords],
    #   #                   :template => menu[:template],
    #   #                   :special_action => menu[:special_action]
    #   #                   )
    #   # location[:lft] = menu[:lft]
    #   # location[:rgt] = menu[:rgt]
    #   # location.save
    #   
    #   Menu.reset_callbacks( :save )
    #   Menu.reset_callbacks( :create )
    #   Menu.reset_callbacks( :validate )
    #   menu[:location_id] = location.id
    #   menu.save
    # end

  end

  def self.down
    remove_column :menus, :location_id
  end
end