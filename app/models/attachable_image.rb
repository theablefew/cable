class AttachableImage < AttachableAsset
  has_attached_file :attachment, :styles => {
    :medium => "400x400>"
  }
end
