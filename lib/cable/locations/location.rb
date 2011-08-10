class Cable::Locations::Location < ActiveRecord::Base
  self.abstract_class = true
  
  belongs_to :locatable, :polymorphic => true, :dependent => :destroy
  # after_save :generate_marketable_url
  # accepts_nested_attributes_for :menus
  serialize :options

  include Cable::Menus::SimpleNavigationMethods
  include Cable::Helpers::UrlHelper
  include Cable::Helpers::NestedSetHelper
  
  scope :use_index, lambda {|index| 
    {:from => "#{quoted_table_name} USE INDEX(#{index})"}
  }
  
  def self.arranged
    arranged = ActiveSupport::OrderedHash.new
    insertion_points = [arranged]
    depth = 0
    # .where(:menus => {:show_in_menu => true} )
    self.includes(:menus).order('lft').each_with_level do |node, level|
      next if level > depth && insertion_points.last.keys.last && node.parent_id != insertion_points.last.keys.last.id
      insertion_points.push insertion_points.last.values.last if level > depth
      (depth - level).times { insertion_points.pop } if level < depth
      insertion_points.last.merge! node => ActiveSupport::OrderedHash.new
      depth = level
    end
    arranged
  end
  #marketable_url is automatic. self.url is only set if user overrides it. 
  def url
    return self[:url] if self.external_link? || self.direct_link?
    return "/#{self.marketable_url}"
  end 
  
  def self.find_by_path( path )
    Location.includes(:menus).find_by_marketable_url( path ) || Location.includes(:menus).find_by_url( "/#{path}" )
  end
    
  
  def resource
    self.locatable_id.nil? ? nil : self.locatable 
  end
  
  def resource=( args )
    resource_type, resource_id = args.scan(/(\w+)|\,\s(\d+)\]/).flatten.compact
    if Cable.resources.include?(resource_type)
      self.locatable_id = resource_id
      self.locatable_type = resource_type
    end
  end
  
  def check_menu_permission( attributed )
    attributed['creatable'] == "0"
  end
  
  def route
    (self.ancestors.collect{|an| an.url } << self.url).join
  end
  
  def generate_marketable_url
    # puts "EXTERNAL LINK " if self.external_link?
    # puts "DIRECT LINK" if self.direct_link?
    unless self.external_link? 
      self.marketable_url = ((self.ancestors.sort_by{|anc| anc.level}.collect{ |a| a.title_or_url.parameterize.to_s } << self.title_or_url.parameterize.to_s))[1..-1].join("/") unless self.direct_link?
      puts "Generating marketable url: #{marketable_url}".color(:yellow)
      puts "Children? #{self.class}".color(:yellow)
      puts ((self.ancestors.sort_by{|anc| anc.level}.collect{ |a| a.title_or_url.parameterize.to_s } << self.title_or_url.parameterize.to_s))[1..-1].join("/")
      self.children.each{|child| child.generate_marketable_url } unless self.children.empty?
    else
      self.marketable_url = ( self.direct_link? ) ? self[:url][1..-1] : self[:url]
    end
    self.save
  end
  
  def title
    title_or_url
  end
  
  def title_or_url
    nme = ""
    return "/" if self.root? 
    unless self.menus.empty?
      nme = self.menus.first.title
    else
      nme = self.resource.title unless self.resource.nil?
    end
    nme = self[:url] unless self[:url].blank?
    return nme
  end


  # def self.menus
  #   Location.roots.collect(&:menus).flatten
  # end
  
end
