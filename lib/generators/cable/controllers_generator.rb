# module Cable
#     module Generators
#       class ControllersGenerator < Rails::Generators::Base
#         source_root File.expand_path("../../../../app/controllers", __FILE__)
#         desc "Copies all Cable admin controllers to your application."
# 
#         argument :scope, :required => false, :default => nil,
#                          :desc => "The scope to copy views to"
# 
#         # class_option :template_engine, :type => :string, :aliases => "-t",
#                                        # :desc => "Template engine for the views. Available options are 'erb' and 'haml'."
# 
#        def copy_controllers
#          copy_file "cable/admin_controller.rb", "app/controllers/admin_controller.rb"
#        end
# 
#       protected
#         #add protected methods here
#       end
#     end
# end
