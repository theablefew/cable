require 'rainbow'
class Cable::Locations::Location < ActiveRecord::Base
  self.abstract_class = true
  
  belongs_to :locatable, :polymorphic => true
  # after_save :generate_marketable_url
  # accepts_nested_attributes_for :menus
  serialize :options

  include Cable::Menus::SimpleNavigationMethods
  include Cable::Helpers::UrlHelper
  include Cable::Helpers::NestedSetHelper
  
  #marketable_url is automatic. self.url is only set if user overrides it. 
  def url
    return self[:url] if self.external_link? || self.direct_link?
    return "/#{self.marketable_url}"
  end
  
  def resource
    self.locatable
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
    if self[:url].blank?
      return "/" if self.root? 
      unless self.menus.empty?
        self.menus.first.title
      else
        self.resource.title
      end
    else
      self[:url]
    end
  end


  def self.menus
    Location.roots.collect(&:menus).flatten
  end
  
end
