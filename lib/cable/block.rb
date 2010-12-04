class Cable::Block < ActiveRecord::Base

  # versioned
  
  # has_attached_file :block_image, :styles => { :small => "150x150>" }
  
  belongs_to :resource, :polymorphic => true
  scope :region , lambda{|*args|  {:conditions => {:region => args.first.to_s } }}

  # attr_accessor :delete_block_image
  # before_save :check_image_deletion
  
  # validates_attachment_content_type :block_image, :content_type => ['image/jpeg', 'image/png']
  # validates_presence_of :title
  private 
  

  
  def check_image_deletion
    # self.block_image.clear if self.delete_block_image.to_i == 1
  end
end


# == Schema Information
#
# Table name: blocks
#
#  id                       :integer(4)      not null, primary key
#  title                    :string(255)
#  body                     :text
#  position                 :integer(4)
#  created_at               :datetime
#  updated_at               :datetime
#  region                   :string(255)
#  resource_id              :integer(4)
#  resource_type            :string(255)
#  url                      :string(255)
#  link_title               :string(255)
#  block_image_file_name    :string(255)
#  block_image_content_type :string(255)
#  block_image_file_size    :integer(4)
#  block_image_updated_at   :datetime
#  sub_head                 :string(255)
#

