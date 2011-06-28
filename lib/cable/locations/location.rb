class Cable::Locations::Location < ActiveRecord::Base
  self.abstract_class = true
  
  validates_presence_of :title
  
  serialize :options

  include Cable::Menu::SimpleNavigationMethods
  
  #TODO: Move UrlHelper to Cable::Helpers::UrlHelper
  include Cable::Menu::UrlHelper
  # Interface for nested_set
  def left=(v)
    lft = v
  end
  
  # Interface for nested_set
  def right=(v)
    rgt = v
  end

  def depth=(v)
  
  end

  def item_id=(v)
  end
  
  def url
    return self[:url] if self.external_link? || self.direct_link?
    return "/#{self.marketable_url}"
  end
  
  def generate_marketable_url
    # puts "EXTERNAL LINK " if self.external_link?
    # puts "DIRECT LINK" if self.direct_link?
    
    unless self.external_link? 
      self.marketable_url = ((self.ancestors.sort_by{|anc| anc.level}.collect{ |a| a.title_or_url.parameterize.to_s } << self.title_or_url.parameterize.to_s))[1..-1].join("/") unless self.direct_link?
      puts "Generating marketable url: #{marketable_url}"
      puts "Children? #{self.class}"
      
      
      unless self.children.empty?
        self.children.each{|child| child.generate_marketable_url }
      end
    else
      self.marketable_url = ( self.direct_link? ) ? self[:url][1..-1] : self[:url]
    end
  
    self.save
  end

  def title_or_url
    if self[:url].blank?
      self.title
    else
      self[:url]
    end
  end

  
end
