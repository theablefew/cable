require 'test_helper'


class LocationsTest < ActiveSupport::TestCase

  should_have_db_column :url
  should_have_db_column :marketable_url
  should_have_db_column :lft
  should_have_db_column :rgt
  
  should have_many(:menus)
  should belong_to(:locatable)
  
  def setup_root_location
    @root = Location.new( :tree_id => 1 )
    @root.menus.build( :title => "Home Navigation" , :show_in_menu => true )
  end
  
  def setup_location
    @location = Location.new( :tree_id => @root.tree_id, :parent_id => @root.id )
    @location.menus.build( :title => "Child Location" , :show_in_menu => true )
  end
  
  def setup_child_location
    @child_location = Location.new( :tree_id => @root.tree_id, :parent_id => @root.id )
    @child_location.menus.build( :title => "Child Location for move" , :show_in_menu => true )
  end
  
  
  context "a root location" do
    setup do 
      setup_root_location
    end
    
    should_not "have more than one menu" do 
      assert_equal @root.menus.length, 1
    end
  end
  
  context "a location" do
    setup do 
      setup_root_location
      setup_location
    end
    
    should "have at least one menu" do
      assert_operator @location.menus.length, :>=, 1
    end
    
    should "have a marketable url" do 
      assert_equal @location.url, "/child-location"
      assert_equal @location[:marketable_url], "child-location"
      assert_nil @location[:url]
    end
    
    should "allow marketable url to be overriden" do
      @location.url = "/custom-location"
      @location.save
      assert_equal @location.url, "/custom-location"
    end
    
  end
  
  context "a location moved" do
    
    setup do 
      setup_root_location
      setup_location
      setup_child_location
    end
    
    should 'have a marketable url' do
      assert_equal @location.url, "/child-location-for-move"
      assert_equal @location[:marketable_url], "child-location-for-move"
      assert_nil @location[:url]
    end
    
    should 'generate a new marketable url'
      @child_location.move_to_child_of( @location)
      assert_equal @child_location.url, "/child-location/child-location-for-move"
      assert_nil @child_location[:url]
      assert_equal @child_location[:marketable_url], "child-location/child-location-for-move"
    end
    
  end

  context "a location with a custom url" do
    should 'not generate a marketable url' do
    end
    
    
    
    
  end
  
  
end