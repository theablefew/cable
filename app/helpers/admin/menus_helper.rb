module Admin::MenusHelper
  def display_tree(tree, parent_id)
    ret = "<ul>"
    tree.each do |node|
      if node.parent_id == parent_id
        begin
          unless node.resource.blank?
            ret += "<li rel='#{node.resource.class.name}' url='#{node.url}' resource_url='#{url_for [:edit, :admin, node.resource]}' id='list_#{node.ressource.id}'>"
          else
            ret += "<li rel='#{node.resource.class.name}' url='#{node.resource}' resource_url='#{url_for [:admin, node.resource]}' id='list_#{node.resource.id}'>"
          end
        rescue Exception => e
          raise Cable::Errors::ResourceAssociationError , "A node has a corrupt resource #{node.inspect}"
        end
        ret += "<a>"
        ret += node.title
        ret += "</a>"
        ret += display_tree(node.children, node.id)
        ret += "</li>"
      end
    end
    ret += "</ul>"
  end
  
  def display_tree_plain(tree, parent_id)
    logger.info "TREE: #{tree.inspect}"
    unless tree.count <= 0
      ret = "<ul>"
      tree.each do |node|
        if node.location.parent_id == parent_id
          logger.info "Node: #{node.inspect}"
          ret += "<li title='#{node.title}' id='#{dom_id(node)}'>"
          ret += "#{node.title}"
          unless node.children.count <= 0
            ret += display_tree_plain(node.children, node.location.id)
          end
          ret += "</li>"
        end
      end
      ret += "</ul>"
    end
  end
  
end