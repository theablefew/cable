class <%= class_name %> < Cable::Page
  <% if options.locatable? %>
    acts_as_cable
  <% end %>
end
