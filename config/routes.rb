#config/routes.rb
# puts Cable::Engine.config.inspect
# Cable::Engine.routes.draw do
  # match '/admin(/:action(/:id))' => 'admin'
# end
Rails.application.routes.draw do |map|
  match '/admin' => 'admin#index'
  match '/admin(/:action(/:id))' => 'admin'
end