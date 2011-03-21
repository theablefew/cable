#config/routes.rb
# puts Cable::Engine.config.inspect
# Cable::Engine.routes.draw do
  # match '/admin(/:action(/:id))' => 'admin'
# end
Rails.application.routes.draw do
  match '/admin' => 'admin#index'
  match '/admin(/:action(/:id))' => 'admin'
  match '*url' => 'main#find_by_url'
end