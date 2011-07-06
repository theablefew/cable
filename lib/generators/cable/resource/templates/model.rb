class <%= class_name %> < Cable::Page
  acts_as_cable
  accepts_nested_attributes_for :location
end
