class <%= class_name %> < Cable::Resource
  <% if options.locatable? %>
    acts_as_cable
  <% end %>
end
