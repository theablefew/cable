# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cable}
  s.version = "0.8.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Spencer Markowski", "The Able Few"]
  s.date = %q{2011-02-25}
  s.files = [
    "app/controllers/admin/cable_settings_controller.rb",
    "app/controllers/admin_controller.rb",
    "app/controllers/attachable_assets_controller.rb",
    "app/controllers/attachable_documents_controller.rb",
    "app/controllers/attachable_images_controller.rb",
    "app/controllers/cable/cable_admin_controller.rb",
    "app/helpers/admin/menus_helper.rb",
    "app/helpers/admin_helper.rb",
    "app/models/attachable_asset.rb",
    "app/models/attachable_document.rb",
    "app/models/attachable_image.rb",
    "app/views/admin/_admin_user_login.html.erb",
    "app/views/admin/cable_settings/_cable_setting.html.erb",
    "app/views/admin/cable_settings/edit.html.erb",
    "app/views/admin/cable_settings/index.html.erb",
    "app/views/admin/index.html.erb",
    "app/views/attachable_assets/index.html.erb",
    "app/views/attachable_assets/new.html.erb",
    "app/views/attachable_assets/show.html.erb",
    "app/views/layouts/_messages.html.erb",
    "app/views/layouts/admin.html.erb",
    "config/admin_navigation.rb",
    "config/navigation.rb",
    "config/routes.rb",
    "lib/cable.rb",
    "lib/cable/acts_as_cable.rb",
    "lib/cable/base.rb",
    "lib/cable/block.rb",
    "lib/cable/controllers/cable_controller_helpers.rb",
    "lib/cable/engine.rb",
    "lib/cable/errors/resource_association_error.rb",
    "lib/cable/media/acts_as_attachable.rb",
    "lib/cable/media/asset.rb",
    "lib/cable/menu.rb",
    "lib/cable/menu/acts_as_cable_menu.rb",
    "lib/cable/menu/base.rb",
    "lib/cable/menu/simple_navigation_methods.rb",
    "lib/cable/menu/url_helper.rb",
    "lib/cable/orm/active_record.rb",
    "lib/cable/page.rb",
    "lib/cable/rails/routes.rb",
    "lib/cable/railtie.rb",
    "lib/cable/schema.rb",
    "lib/cable/setting.rb",
    "lib/cable/special_action.rb",
    "lib/generators/cable/install_generator.rb",
    "lib/generators/cable/media/media_generator.rb",
    "lib/generators/cable/media/templates/migration.rb",
    "lib/generators/cable/media/templates/model.rb",
    "lib/generators/cable/menu/menu_generator.rb",
    "lib/generators/cable/menu/templates/controller.rb",
    "lib/generators/cable/menu/templates/erb/menus/_menu.html.erb",
    "lib/generators/cable/menu/templates/erb/menus/_menu_children_table.html.erb",
    "lib/generators/cable/menu/templates/erb/menus/_menu_tree.html.erb",
    "lib/generators/cable/menu/templates/erb/menus/_menu_vitals.html.erb",
    "lib/generators/cable/menu/templates/erb/menus/_resource.html.erb",
    "lib/generators/cable/menu/templates/erb/menus/_resource_fields.html.erb",
    "lib/generators/cable/menu/templates/erb/menus/_tree.html.erb",
    "lib/generators/cable/menu/templates/erb/menus/edit.html.erb",
    "lib/generators/cable/menu/templates/erb/menus/index.html.erb",
    "lib/generators/cable/menu/templates/erb/menus/move.html.erb",
    "lib/generators/cable/menu/templates/erb/menus/new.html.erb",
    "lib/generators/cable/menu/templates/erb/menus/show.html.erb",
    "lib/generators/cable/menu/templates/erb/menus/table.html.erb",
    "lib/generators/cable/menu/templates/erb/partials/_menu_fields.html.erb",
    "lib/generators/cable/menu/templates/migration.rb",
    "lib/generators/cable/menu/templates/model.rb",
    "lib/generators/cable/orm_helpers.rb",
    "lib/generators/cable/override_generator.rb",
    "lib/generators/cable/resource/resource_generator.rb",
    "lib/generators/cable/resource/templates/controller.rb",
    "lib/generators/cable/resource/templates/erb/scaffold/_form.html.erb",
    "lib/generators/cable/resource/templates/erb/scaffold/edit.html.erb",
    "lib/generators/cable/resource/templates/erb/scaffold/index.html.erb",
    "lib/generators/cable/resource/templates/erb/scaffold/new.html.erb",
    "lib/generators/cable/resource/templates/erb/scaffold/show.html.erb",
    "lib/generators/cable/resource/templates/migration.rb",
    "lib/generators/cable/resource/templates/model.rb",
    "lib/generators/templates/block.rb",
    "lib/generators/templates/create_blocks.rb",
    "lib/generators/templates/create_cable_settings.rb",
    "lib/generators/templates/initializer.rb",
    "lib/generators/templates/partials/_block.html.erb",
    "lib/generators/templates/partials/_block_form.html.erb",
    "lib/railties/tasks.rake",
    "public/images/cable/background.png",
    "public/images/cable/delete.png",
    "public/images/cable/event-icon.png",
    "public/images/cable/new-window.png",
    "public/images/cable/nil-icon.png",
    "public/images/cable/page-icon.png",
    "public/images/cable/product-icon.jpg",
    "public/images/cable/story-icon.jpg",
    "public/images/iphone-style-checkboxes/off.png",
    "public/images/iphone-style-checkboxes/on.png",
    "public/images/iphone-style-checkboxes/slider.png",
    "public/images/iphone-style-checkboxes/slider_center.png",
    "public/images/iphone-style-checkboxes/slider_left.png",
    "public/images/iphone-style-checkboxes/slider_right.png",
    "public/javascripts/admin.js",
    "public/javascripts/iphone-style-checkboxes.js",
    "public/javascripts/jquery.columnview.js",
    "public/javascripts/jquery.tablesorter.min.js",
    "public/javascripts/jquery.tagsinput.js",
    "public/javascripts/jstree/_lib/jquery.cookie.js",
    "public/javascripts/jstree/_lib/jquery.hotkeys.js",
    "public/javascripts/jstree/_lib/jquery.js",
    "public/javascripts/jstree/jquery.jstree.js",
    "public/javascripts/jstree/themes/apple/bg.jpg",
    "public/javascripts/jstree/themes/apple/d.png",
    "public/javascripts/jstree/themes/apple/dot_for_ie.gif",
    "public/javascripts/jstree/themes/apple/style.css",
    "public/javascripts/jstree/themes/apple/throbber.gif",
    "public/javascripts/jstree/themes/classic/d.png",
    "public/javascripts/jstree/themes/classic/dot_for_ie.gif",
    "public/javascripts/jstree/themes/classic/style.css",
    "public/javascripts/jstree/themes/classic/throbber.gif",
    "public/javascripts/jstree/themes/default-rtl/d.gif",
    "public/javascripts/jstree/themes/default-rtl/d.png",
    "public/javascripts/jstree/themes/default-rtl/dots.gif",
    "public/javascripts/jstree/themes/default-rtl/style.css",
    "public/javascripts/jstree/themes/default-rtl/throbber.gif",
    "public/javascripts/jstree/themes/default/d.gif",
    "public/javascripts/jstree/themes/default/d.png",
    "public/javascripts/jstree/themes/default/style.css",
    "public/javascripts/jstree/themes/default/throbber.gif",
    "public/javascripts/tinymce/jquery.tinymce.js",
    "public/javascripts/tinymce/langs/en.js",
    "public/javascripts/tinymce/license.txt",
    "public/javascripts/tinymce/plugins/advhr/css/advhr.css",
    "public/javascripts/tinymce/plugins/advhr/editor_plugin.js",
    "public/javascripts/tinymce/plugins/advhr/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/advhr/js/rule.js",
    "public/javascripts/tinymce/plugins/advhr/langs/en_dlg.js",
    "public/javascripts/tinymce/plugins/advhr/rule.htm",
    "public/javascripts/tinymce/plugins/advimage/css/advimage.css",
    "public/javascripts/tinymce/plugins/advimage/editor_plugin.js",
    "public/javascripts/tinymce/plugins/advimage/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/advimage/image.htm",
    "public/javascripts/tinymce/plugins/advimage/img/sample.gif",
    "public/javascripts/tinymce/plugins/advimage/js/image.js",
    "public/javascripts/tinymce/plugins/advimage/langs/en_dlg.js",
    "public/javascripts/tinymce/plugins/advlink/css/advlink.css",
    "public/javascripts/tinymce/plugins/advlink/editor_plugin.js",
    "public/javascripts/tinymce/plugins/advlink/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/advlink/js/advlink.js",
    "public/javascripts/tinymce/plugins/advlink/langs/en_dlg.js",
    "public/javascripts/tinymce/plugins/advlink/link.htm",
    "public/javascripts/tinymce/plugins/advlist/editor_plugin.js",
    "public/javascripts/tinymce/plugins/advlist/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/autoresize/editor_plugin.js",
    "public/javascripts/tinymce/plugins/autoresize/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/autosave/editor_plugin.js",
    "public/javascripts/tinymce/plugins/autosave/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/autosave/langs/en.js",
    "public/javascripts/tinymce/plugins/bbcode/editor_plugin.js",
    "public/javascripts/tinymce/plugins/bbcode/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/contextmenu/editor_plugin.js",
    "public/javascripts/tinymce/plugins/contextmenu/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/directionality/editor_plugin.js",
    "public/javascripts/tinymce/plugins/directionality/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/emotions/editor_plugin.js",
    "public/javascripts/tinymce/plugins/emotions/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/emotions/emotions.htm",
    "public/javascripts/tinymce/plugins/emotions/img/smiley-cool.gif",
    "public/javascripts/tinymce/plugins/emotions/img/smiley-cry.gif",
    "public/javascripts/tinymce/plugins/emotions/img/smiley-embarassed.gif",
    "public/javascripts/tinymce/plugins/emotions/img/smiley-foot-in-mouth.gif",
    "public/javascripts/tinymce/plugins/emotions/img/smiley-frown.gif",
    "public/javascripts/tinymce/plugins/emotions/img/smiley-innocent.gif",
    "public/javascripts/tinymce/plugins/emotions/img/smiley-kiss.gif",
    "public/javascripts/tinymce/plugins/emotions/img/smiley-laughing.gif",
    "public/javascripts/tinymce/plugins/emotions/img/smiley-money-mouth.gif",
    "public/javascripts/tinymce/plugins/emotions/img/smiley-sealed.gif",
    "public/javascripts/tinymce/plugins/emotions/img/smiley-smile.gif",
    "public/javascripts/tinymce/plugins/emotions/img/smiley-surprised.gif",
    "public/javascripts/tinymce/plugins/emotions/img/smiley-tongue-out.gif",
    "public/javascripts/tinymce/plugins/emotions/img/smiley-undecided.gif",
    "public/javascripts/tinymce/plugins/emotions/img/smiley-wink.gif",
    "public/javascripts/tinymce/plugins/emotions/img/smiley-yell.gif",
    "public/javascripts/tinymce/plugins/emotions/js/emotions.js",
    "public/javascripts/tinymce/plugins/emotions/langs/en_dlg.js",
    "public/javascripts/tinymce/plugins/example/dialog.htm",
    "public/javascripts/tinymce/plugins/example/editor_plugin.js",
    "public/javascripts/tinymce/plugins/example/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/example/img/example.gif",
    "public/javascripts/tinymce/plugins/example/js/dialog.js",
    "public/javascripts/tinymce/plugins/example/langs/en.js",
    "public/javascripts/tinymce/plugins/example/langs/en_dlg.js",
    "public/javascripts/tinymce/plugins/fullpage/css/fullpage.css",
    "public/javascripts/tinymce/plugins/fullpage/editor_plugin.js",
    "public/javascripts/tinymce/plugins/fullpage/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/fullpage/fullpage.htm",
    "public/javascripts/tinymce/plugins/fullpage/js/fullpage.js",
    "public/javascripts/tinymce/plugins/fullpage/langs/en_dlg.js",
    "public/javascripts/tinymce/plugins/fullscreen/editor_plugin.js",
    "public/javascripts/tinymce/plugins/fullscreen/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/fullscreen/fullscreen.htm",
    "public/javascripts/tinymce/plugins/iespell/editor_plugin.js",
    "public/javascripts/tinymce/plugins/iespell/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/inlinepopups/editor_plugin.js",
    "public/javascripts/tinymce/plugins/inlinepopups/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/inlinepopups/skins/clearlooks2/img/alert.gif",
    "public/javascripts/tinymce/plugins/inlinepopups/skins/clearlooks2/img/button.gif",
    "public/javascripts/tinymce/plugins/inlinepopups/skins/clearlooks2/img/buttons.gif",
    "public/javascripts/tinymce/plugins/inlinepopups/skins/clearlooks2/img/confirm.gif",
    "public/javascripts/tinymce/plugins/inlinepopups/skins/clearlooks2/img/corners.gif",
    "public/javascripts/tinymce/plugins/inlinepopups/skins/clearlooks2/img/horizontal.gif",
    "public/javascripts/tinymce/plugins/inlinepopups/skins/clearlooks2/img/vertical.gif",
    "public/javascripts/tinymce/plugins/inlinepopups/skins/clearlooks2/window.css",
    "public/javascripts/tinymce/plugins/inlinepopups/template.htm",
    "public/javascripts/tinymce/plugins/insertdatetime/editor_plugin.js",
    "public/javascripts/tinymce/plugins/insertdatetime/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/layer/editor_plugin.js",
    "public/javascripts/tinymce/plugins/layer/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/legacyoutput/editor_plugin.js",
    "public/javascripts/tinymce/plugins/legacyoutput/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/media/css/content.css",
    "public/javascripts/tinymce/plugins/media/css/media.css",
    "public/javascripts/tinymce/plugins/media/editor_plugin.js",
    "public/javascripts/tinymce/plugins/media/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/media/img/flash.gif",
    "public/javascripts/tinymce/plugins/media/img/flv_player.swf",
    "public/javascripts/tinymce/plugins/media/img/quicktime.gif",
    "public/javascripts/tinymce/plugins/media/img/realmedia.gif",
    "public/javascripts/tinymce/plugins/media/img/shockwave.gif",
    "public/javascripts/tinymce/plugins/media/img/trans.gif",
    "public/javascripts/tinymce/plugins/media/img/windowsmedia.gif",
    "public/javascripts/tinymce/plugins/media/js/embed.js",
    "public/javascripts/tinymce/plugins/media/js/media.js",
    "public/javascripts/tinymce/plugins/media/langs/en_dlg.js",
    "public/javascripts/tinymce/plugins/media/media.htm",
    "public/javascripts/tinymce/plugins/nonbreaking/editor_plugin.js",
    "public/javascripts/tinymce/plugins/nonbreaking/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/noneditable/editor_plugin.js",
    "public/javascripts/tinymce/plugins/noneditable/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/pagebreak/css/content.css",
    "public/javascripts/tinymce/plugins/pagebreak/editor_plugin.js",
    "public/javascripts/tinymce/plugins/pagebreak/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/pagebreak/img/pagebreak.gif",
    "public/javascripts/tinymce/plugins/pagebreak/img/trans.gif",
    "public/javascripts/tinymce/plugins/paste/editor_plugin.js",
    "public/javascripts/tinymce/plugins/paste/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/paste/js/pastetext.js",
    "public/javascripts/tinymce/plugins/paste/js/pasteword.js",
    "public/javascripts/tinymce/plugins/paste/langs/en_dlg.js",
    "public/javascripts/tinymce/plugins/paste/pastetext.htm",
    "public/javascripts/tinymce/plugins/paste/pasteword.htm",
    "public/javascripts/tinymce/plugins/pdw/editor_plugin.js",
    "public/javascripts/tinymce/plugins/pdw/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/pdw/img/toolbars.gif",
    "public/javascripts/tinymce/plugins/pdw/langs/en.js",
    "public/javascripts/tinymce/plugins/pdw/langs/nl.js",
    "public/javascripts/tinymce/plugins/preview/editor_plugin.js",
    "public/javascripts/tinymce/plugins/preview/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/preview/example.html",
    "public/javascripts/tinymce/plugins/preview/jscripts/embed.js",
    "public/javascripts/tinymce/plugins/preview/preview.html",
    "public/javascripts/tinymce/plugins/print/editor_plugin.js",
    "public/javascripts/tinymce/plugins/print/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/save/editor_plugin.js",
    "public/javascripts/tinymce/plugins/save/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/searchreplace/css/searchreplace.css",
    "public/javascripts/tinymce/plugins/searchreplace/editor_plugin.js",
    "public/javascripts/tinymce/plugins/searchreplace/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/searchreplace/js/searchreplace.js",
    "public/javascripts/tinymce/plugins/searchreplace/langs/en_dlg.js",
    "public/javascripts/tinymce/plugins/searchreplace/searchreplace.htm",
    "public/javascripts/tinymce/plugins/spellchecker/css/content.css",
    "public/javascripts/tinymce/plugins/spellchecker/editor_plugin.js",
    "public/javascripts/tinymce/plugins/spellchecker/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/spellchecker/img/wline.gif",
    "public/javascripts/tinymce/plugins/style/css/props.css",
    "public/javascripts/tinymce/plugins/style/editor_plugin.js",
    "public/javascripts/tinymce/plugins/style/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/style/js/props.js",
    "public/javascripts/tinymce/plugins/style/langs/en_dlg.js",
    "public/javascripts/tinymce/plugins/style/props.htm",
    "public/javascripts/tinymce/plugins/tabfocus/editor_plugin.js",
    "public/javascripts/tinymce/plugins/tabfocus/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/table/cell.htm",
    "public/javascripts/tinymce/plugins/table/css/cell.css",
    "public/javascripts/tinymce/plugins/table/css/row.css",
    "public/javascripts/tinymce/plugins/table/css/table.css",
    "public/javascripts/tinymce/plugins/table/editor_plugin.js",
    "public/javascripts/tinymce/plugins/table/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/table/js/cell.js",
    "public/javascripts/tinymce/plugins/table/js/merge_cells.js",
    "public/javascripts/tinymce/plugins/table/js/row.js",
    "public/javascripts/tinymce/plugins/table/js/table.js",
    "public/javascripts/tinymce/plugins/table/langs/en_dlg.js",
    "public/javascripts/tinymce/plugins/table/merge_cells.htm",
    "public/javascripts/tinymce/plugins/table/row.htm",
    "public/javascripts/tinymce/plugins/table/table.htm",
    "public/javascripts/tinymce/plugins/template/blank.htm",
    "public/javascripts/tinymce/plugins/template/css/template.css",
    "public/javascripts/tinymce/plugins/template/editor_plugin.js",
    "public/javascripts/tinymce/plugins/template/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/template/js/template.js",
    "public/javascripts/tinymce/plugins/template/langs/en_dlg.js",
    "public/javascripts/tinymce/plugins/template/template.htm",
    "public/javascripts/tinymce/plugins/visualchars/editor_plugin.js",
    "public/javascripts/tinymce/plugins/visualchars/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/wordcount/editor_plugin.js",
    "public/javascripts/tinymce/plugins/wordcount/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/xhtmlxtras/abbr.htm",
    "public/javascripts/tinymce/plugins/xhtmlxtras/acronym.htm",
    "public/javascripts/tinymce/plugins/xhtmlxtras/attributes.htm",
    "public/javascripts/tinymce/plugins/xhtmlxtras/cite.htm",
    "public/javascripts/tinymce/plugins/xhtmlxtras/css/attributes.css",
    "public/javascripts/tinymce/plugins/xhtmlxtras/css/popup.css",
    "public/javascripts/tinymce/plugins/xhtmlxtras/del.htm",
    "public/javascripts/tinymce/plugins/xhtmlxtras/editor_plugin.js",
    "public/javascripts/tinymce/plugins/xhtmlxtras/editor_plugin_src.js",
    "public/javascripts/tinymce/plugins/xhtmlxtras/ins.htm",
    "public/javascripts/tinymce/plugins/xhtmlxtras/js/abbr.js",
    "public/javascripts/tinymce/plugins/xhtmlxtras/js/acronym.js",
    "public/javascripts/tinymce/plugins/xhtmlxtras/js/attributes.js",
    "public/javascripts/tinymce/plugins/xhtmlxtras/js/cite.js",
    "public/javascripts/tinymce/plugins/xhtmlxtras/js/del.js",
    "public/javascripts/tinymce/plugins/xhtmlxtras/js/element_common.js",
    "public/javascripts/tinymce/plugins/xhtmlxtras/js/ins.js",
    "public/javascripts/tinymce/plugins/xhtmlxtras/langs/en_dlg.js",
    "public/javascripts/tinymce/themes/advanced/about.htm",
    "public/javascripts/tinymce/themes/advanced/anchor.htm",
    "public/javascripts/tinymce/themes/advanced/charmap.htm",
    "public/javascripts/tinymce/themes/advanced/color_picker.htm",
    "public/javascripts/tinymce/themes/advanced/editor_template.js",
    "public/javascripts/tinymce/themes/advanced/editor_template_src.js",
    "public/javascripts/tinymce/themes/advanced/image.htm",
    "public/javascripts/tinymce/themes/advanced/img/colorpicker.jpg",
    "public/javascripts/tinymce/themes/advanced/img/icons.gif",
    "public/javascripts/tinymce/themes/advanced/js/about.js",
    "public/javascripts/tinymce/themes/advanced/js/anchor.js",
    "public/javascripts/tinymce/themes/advanced/js/charmap.js",
    "public/javascripts/tinymce/themes/advanced/js/color_picker.js",
    "public/javascripts/tinymce/themes/advanced/js/image.js",
    "public/javascripts/tinymce/themes/advanced/js/link.js",
    "public/javascripts/tinymce/themes/advanced/js/source_editor.js",
    "public/javascripts/tinymce/themes/advanced/langs/en.js",
    "public/javascripts/tinymce/themes/advanced/langs/en_dlg.js",
    "public/javascripts/tinymce/themes/advanced/link.htm",
    "public/javascripts/tinymce/themes/advanced/skins/default/content.css",
    "public/javascripts/tinymce/themes/advanced/skins/default/dialog.css",
    "public/javascripts/tinymce/themes/advanced/skins/default/img/buttons.png",
    "public/javascripts/tinymce/themes/advanced/skins/default/img/items.gif",
    "public/javascripts/tinymce/themes/advanced/skins/default/img/menu_arrow.gif",
    "public/javascripts/tinymce/themes/advanced/skins/default/img/menu_check.gif",
    "public/javascripts/tinymce/themes/advanced/skins/default/img/progress.gif",
    "public/javascripts/tinymce/themes/advanced/skins/default/img/tabs.gif",
    "public/javascripts/tinymce/themes/advanced/skins/default/ui.css",
    "public/javascripts/tinymce/themes/advanced/skins/o2k7/content.css",
    "public/javascripts/tinymce/themes/advanced/skins/o2k7/dialog.css",
    "public/javascripts/tinymce/themes/advanced/skins/o2k7/img/button_bg.png",
    "public/javascripts/tinymce/themes/advanced/skins/o2k7/img/button_bg_black.png",
    "public/javascripts/tinymce/themes/advanced/skins/o2k7/img/button_bg_silver.png",
    "public/javascripts/tinymce/themes/advanced/skins/o2k7/ui.css",
    "public/javascripts/tinymce/themes/advanced/skins/o2k7/ui_black.css",
    "public/javascripts/tinymce/themes/advanced/skins/o2k7/ui_silver.css",
    "public/javascripts/tinymce/themes/advanced/source_editor.htm",
    "public/javascripts/tinymce/themes/simple/editor_template.js",
    "public/javascripts/tinymce/themes/simple/editor_template_src.js",
    "public/javascripts/tinymce/themes/simple/img/icons.gif",
    "public/javascripts/tinymce/themes/simple/langs/en.js",
    "public/javascripts/tinymce/themes/simple/skins/default/content.css",
    "public/javascripts/tinymce/themes/simple/skins/default/ui.css",
    "public/javascripts/tinymce/themes/simple/skins/o2k7/content.css",
    "public/javascripts/tinymce/themes/simple/skins/o2k7/img/button_bg.png",
    "public/javascripts/tinymce/themes/simple/skins/o2k7/ui.css",
    "public/javascripts/tinymce/tiny_mce.js",
    "public/javascripts/tinymce/tiny_mce_popup.js",
    "public/javascripts/tinymce/tiny_mce_src.js",
    "public/javascripts/tinymce/utils/editable_selects.js",
    "public/javascripts/tinymce/utils/form_utils.js",
    "public/javascripts/tinymce/utils/mctabs.js",
    "public/javascripts/tinymce/utils/validate.js",
    "public/stylesheets/cable.css",
    "public/stylesheets/cable/blueprint/ie.css",
    "public/stylesheets/cable/blueprint/plugins/buttons/icons/cross.png",
    "public/stylesheets/cable/blueprint/plugins/buttons/icons/key.png",
    "public/stylesheets/cable/blueprint/plugins/buttons/icons/tick.png",
    "public/stylesheets/cable/blueprint/plugins/buttons/readme.txt",
    "public/stylesheets/cable/blueprint/plugins/buttons/screen.css",
    "public/stylesheets/cable/blueprint/plugins/fancy-type/readme.txt",
    "public/stylesheets/cable/blueprint/plugins/fancy-type/screen.css",
    "public/stylesheets/cable/blueprint/plugins/link-icons/icons/doc.png",
    "public/stylesheets/cable/blueprint/plugins/link-icons/icons/email.png",
    "public/stylesheets/cable/blueprint/plugins/link-icons/icons/external.png",
    "public/stylesheets/cable/blueprint/plugins/link-icons/icons/feed.png",
    "public/stylesheets/cable/blueprint/plugins/link-icons/icons/im.png",
    "public/stylesheets/cable/blueprint/plugins/link-icons/icons/pdf.png",
    "public/stylesheets/cable/blueprint/plugins/link-icons/icons/visited.png",
    "public/stylesheets/cable/blueprint/plugins/link-icons/icons/xls.png",
    "public/stylesheets/cable/blueprint/plugins/link-icons/readme.txt",
    "public/stylesheets/cable/blueprint/plugins/link-icons/screen.css",
    "public/stylesheets/cable/blueprint/plugins/rtl/readme.txt",
    "public/stylesheets/cable/blueprint/plugins/rtl/screen.css",
    "public/stylesheets/cable/blueprint/print.css",
    "public/stylesheets/cable/blueprint/screen.css",
    "public/stylesheets/cable/blueprint/src/forms.css",
    "public/stylesheets/cable/blueprint/src/grid.css",
    "public/stylesheets/cable/blueprint/src/grid.png",
    "public/stylesheets/cable/blueprint/src/ie.css",
    "public/stylesheets/cable/blueprint/src/print.css",
    "public/stylesheets/cable/blueprint/src/reset.css",
    "public/stylesheets/cable/blueprint/src/typography.css",
    "public/stylesheets/formtastic.css",
    "public/stylesheets/formtastic_changes.css",
    "public/stylesheets/iphone_checkboxes.css",
    "public/stylesheets/ui/aristo/aristo.css",
    "public/stylesheets/ui/aristo/icons.psd",
    "public/stylesheets/ui/aristo/images/button_bg.png",
    "public/stylesheets/ui/aristo/images/datepicker.gif",
    "public/stylesheets/ui/aristo/images/icon_sprite.png",
    "public/stylesheets/ui/aristo/images/progress_bar.gif",
    "public/stylesheets/ui/aristo/images/right-arrow.png",
    "public/stylesheets/ui/aristo/images/slider_h_bg.gif",
    "public/stylesheets/ui/aristo/images/slider_handles.png",
    "public/stylesheets/ui/aristo/images/slider_v_bg.gif",
    "public/stylesheets/ui/aristo/images/tab_bg.gif",
    "public/stylesheets/ui/aristo/images/the_gradient.gif",
    "public/stylesheets/ui/aristo/images/ui-bg_diagonals-thick_18_b81900_40x40.png",
    "public/stylesheets/ui/aristo/images/ui-bg_diagonals-thick_20_666666_40x40.png",
    "public/stylesheets/ui/aristo/images/ui-bg_flat_10_000000_40x100.png",
    "public/stylesheets/ui/aristo/images/ui-bg_glass_100_f6f6f6_1x400.png",
    "public/stylesheets/ui/aristo/images/ui-bg_glass_100_fdf5ce_1x400.png",
    "public/stylesheets/ui/aristo/images/ui-bg_glass_65_ffffff_1x400.png",
    "public/stylesheets/ui/aristo/images/ui-bg_gloss-wave_35_f6a828_500x100.png",
    "public/stylesheets/ui/aristo/images/ui-bg_highlight-soft_100_eeeeee_1x100.png",
    "public/stylesheets/ui/aristo/images/ui-bg_highlight-soft_75_ffe45c_1x100.png",
    "public/stylesheets/ui/aristo/images/ui-icons_222222_256x240.png",
    "public/stylesheets/ui/aristo/images/ui-icons_228ef1_256x240.png",
    "public/stylesheets/ui/aristo/images/ui-icons_ef8c08_256x240.png",
    "public/stylesheets/ui/aristo/images/ui-icons_ffd27a_256x240.png",
    "public/stylesheets/ui/aristo/images/ui-icons_ffffff_256x240.png",
    "public/stylesheets/ui/images/sprite-aristo.png",
    "public/stylesheets/ui/images/uniform/sprite.png",
    "public/stylesheets/ui/uniform/uniform.aristo.css",
    "public/stylesheets/ui/uniform/uniform.default.css"
  ]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{Cable Admin Engine for Rails 3}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["~> 3.0.0"])
      s.add_runtime_dependency(%q<orm_adapter>, [">= 0"])
      s.add_runtime_dependency(%q<awesome_nested_set>, [">= 0"])
    else
      s.add_dependency(%q<rails>, ["~> 3.0.0"])
      s.add_dependency(%q<orm_adapter>, [">= 0"])
      s.add_dependency(%q<awesome_nested_set>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, ["~> 3.0.0"])
    s.add_dependency(%q<orm_adapter>, [">= 0"])
    s.add_dependency(%q<awesome_nested_set>, [">= 0"])
  end
end

