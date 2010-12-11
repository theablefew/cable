class AttachableAsset < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true

  has_attached_file :attachment, :styles => {
    :medium => "400x400>"
  }

  def attachable_type=(s_type)
    super(s_type.to_s.classify.constantize.class.to_s)
  end
end
