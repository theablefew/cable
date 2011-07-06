(function($){
  
  var xhr;
  var parent_id;

  var sortable_options = {
    items: "li:not(#add-menu)",
    connectWith: '.cable_menu_wrapper ul',
    appendTo: '.cable_menu_wrapper',
    helper: 'clone',
    placeholder: "ui-state-highlight",
    delay: 100,
    stop: function(event, ui){
      $tree = $(".cable_menu_wrapper > ul");
      update_tree($tree);
      select_item(ui.item[0]);
      $('ul.empty').removeClass('.empty');
    },
    update: function(event, ui) {
      
    },
    receive: function(event, ui) {
        console.log( "receive event");
      $target = $(event.target);
      $item = $(ui.item[0]);
      $children_of_item = $item.data("children");  
      $id_of_item = $item.attr("menu");
      $id_of_target = $target.attr("menu");               
      var $test_for_children = $children_of_item.indexOf(parseInt($id_of_target));
      if($test_for_children < 0){

      }else{
        $(ui.sender).sortable('cancel');                          
      }
      if($id_of_item == $id_of_target){
        $(ui.sender).sortable('cancel');          
      }  
    }
  };
  
  function save_tree(){
    
    $(".cable_menu_wrapper li").each(function() {
      $li = $(this);      
      $ul = $("ul[menu="+$li.attr("menu")+"]");
      $ul.removeAttr("id");
      $li.append($ul);
      $li.attr("id", "menu_"+$li.attr("menu"));
    });
    $(".cable_menu_wrapper").find("ul").unbind("mouseenter");
    $(".cable_menu_wrapper").find("ul").unbind("mouseleave");
    $('.cable_menu_wrapper > ul').removeAttr("id");
    
    var the_menu = $('.cable_menu_wrapper > ul').serialize_list();
    $('.cable_menu_wrapper').html("Saving ...");
    $.post("/admin/menus/sort", the_menu, function(){
      location.reload(true);
    });
  }
  
  function show_add_menu(item){

    $("#add-menu").remove();
    
    var $add = $("<li id='add-menu'>Add Menu Item</li>").appendTo($(item));

    $add.click(function(){
      var id = $(item).attr("menu");
      $("#add-menu-form").html("<img src='/images/cable/loader.gif' />");
      $("#add-menu-form").load("/admin/menus/new", function(){
        $(this).dialog({
          modal: true,
          width: 600,
      resizable: false,
          title: "New Menu",
      draggable: false
        });
      });
    });
  }
  
  function hide_add_menu(item){
    // $item = $(item);
    // $item.css({"padding-bottom":"0px","height":"340px"});
    $("#add-menu").remove();
  }
  
  function update_parents(item){
    var $li = $(item);
    var $id = $li.attr("menu");
    var $pli = $("li[menu="+$id+"]");
    
    var $parents = [];
    
    var $pid = $pli.parent().attr("menu");
    $parents.push(parseInt($pid));
    if($pid != 0){
      var $arr = update_parents($pli.parent())
      var len= $arr.length;
      for(var i=0; i<len; i++) {
        $parents.push(parseInt($arr[i]));
      }
    }
    $li.data("parents",$parents);
    return $parents;
  }
  
  function update_children(item){
    var $li = $(item);
    var $id = $li.attr("menu");
    var $ul = $("ul[menu="+$id+"]");
    
    if($ul.children().size() == 0){
        console.log( $li.attr('title') + " has no children");
      $li.removeClass("has-children").addClass("empty");
    }else{
        console.log( $li.attr('title') + " has children");
      $li.removeClass('empty').addClass("has-children");
    }
    
    var $children = [];
    $ul.children().each(function(){
      $cid = $(this).attr("menu");
      $cul = $("ul[menu="+$cid+"]");
      $children.push(parseInt($cid));
      var $arr = update_children(this);
      var len= $arr.length;
      for(var i=0; i<len; i++) {
        $children.push(parseInt($arr[i]));
      }
    })

    $li.data("children",$children);
    
    return $children;    
  }
  
  function update_breadcrumb(){
    var items = new Array();
    $(".cable_menu_wrapper .selected").removeClass("last");
    $(".cable_menu_wrapper .selected").each(function(){
      items.push([$(this).text(), $(this).attr("menu")]);
    });
    items.sort(function(a,b) {return a[1] == b[1] ? 0 : (a[1] < b[1] ? -1 : 1)})
    sorted_items = []
    $.each( items , function(index, value) {
        sorted_items.push( value[0]);
    } );
    $("#selection p").html(sorted_items.join(" &raquo; "));
    $(".cable_menu_wrapper .selected").last().addClass("last");
  }
  
  function select_item(item,wrapper){
    $item = $(item);

    // window.location.hash = $item.attr("title");
    $id = $(item).attr("menu");
	parent_id = $id;
    $wrapper = $(wrapper);
    $child = $("ul[menu="+$id+"]");

    if($child.children().size() > 0){
      $child.css({ left: $item.parent().position().left + $item.parent().width()+3+$(".cable_menu_wrapper").scrollLeft(), top: 0}).show();      
    }else{
      $("<ul class='cable_menu empty' menu="+$id+"/>").css({ left: $item.parent().position().left + $item.parent().width()+3+$(".cable_menu_wrapper").scrollLeft(), top: 0}).sortable(sortable_options).appendTo($wrapper).mouseenter(function() {   
       });;
    }
    
    $item.addClass("selected");
    
    $item.siblings('.selected').each(function(){
      deselect(this);
    });
    
    $child.children().each(function(){
      deselect(this);
    });
        
    $wrapper.append($item.parent());
    last_width = $wrapper.attr("scrollWidth");
    $wrapper.stop();
    $wrapper.animate({ 'scrollLeft': $wrapper.attr("scrollWidth") }, 2000);
    
    update_breadcrumb();
  }
  
  function zoom_item(item,wrapper){
    $item = $(item);
    $id = $(item).attr("menu");
    $wrapper = $(wrapper);
        
    if(xhr != undefined) {
      xhr.abort(); 
    } 
    xhr = $.ajax({
      url: "/admin/menus/"+$item.attr("menu"),
      success: function(data) {
        $("#menu-details").html(data).dialog(
          {
            modal: true, 
            width: 600,
            height: 250,
            resizable: false,
            draggable: false,
            resizable: false,
            title: "Displaying menu properties"
          }
        );
      }
    });
  }

  function deselect(item) {
    var $item = $(item);
    $item.removeClass('selected');
    $id = $item.attr("menu");
    $child = $("ul[menu="+$id+"]");
    $child.hide().find("li").each(function(){
      deselect(this);
    });
    
  }
  
  function update_tree(tree){
    $tree = $(tree);
    $tree.find("li").each(function(){
     update_children(this); 
     update_parents(this);
    });
  }
  
  function build_menu(ul, wrapper, id){
    var $wrapper = $(wrapper);
    var $ul = $(ul);
    var $id = id;
    var $new_menu = $("<ul class='cable_menu' menu="+$id+"/>").appendTo($wrapper);
    if($id >= 1){
      $new_menu.hide();
    }    
    $ul.children().each(function(){
      var $li = $(this);
      var $cloned_li = $(this).clone();
      if($cloned_li.children().size() > 0){ 
        $cloned_li.addClass("has-children");
        var $id = $cloned_li.attr("id").replace("menu_","");        
        $cloned_li.children().each(function(){
          build_menu(this,$wrapper,$id);
        });
      }
      $cloned_li.find("ul").remove();
      $cloned_li.html("<span class='menu-zoom'></span> <span class='menu-title'>"+$cloned_li.text()+"</span>");
      $cloned_li.appendTo($new_menu);
      $cloned_li.attr("menu",$cloned_li.attr("id").replace("menu_",""));      
      $cloned_li.removeAttr("id");


    });
  }

  $.fn.serialize_list = function(options) {
    var defaults = {
      attributes: ['id'],
      allow_nesting: true, 
      prepend: 'ul', 
      att_regex: false, 
      is_child: false
    };
    
    var opts = $.extend(defaults, options);
    var serialized_string = '';
    
    if(!opts.is_child){
      opts.prepend = '&'+opts.prepend;
    }
    
    this.each(function() {
      var li_count = 0;
      $(this).children().each(function(){
        if(opts.allow_nesting || opts.attributes.length > 1){
          for(att in opts.attributes){
            val = att_rep(opts.attributes[att], $(this).attr(opts.attributes[att]));
            serialized_string += opts.prepend+'['+li_count+']['+opts.attributes[att]+']='+val;
          }
        } else {
          val = att_rep(opts.attributes[0], $(this).attr(opts.attributes[0]));
          serialized_string += opts.prepend+'['+li_count+']='+val;
        }
        
        if(opts.allow_nesting){
          var child_base = opts.prepend+'['+li_count+'][children]';
          $(this).children().each(function(){
            if(this.tagName == 'UL' || this.tagName == 'OL'){
              serialized_string += $(this).serialize_list({'prepend': child_base, 'is_child': true});
            }
          });
        }
        li_count++;
      });
      function att_rep (att, val){
        if(opts.att_regex){
          for(x in opts.att_regex){
            if(opts.att_regex[x].att == att){
              return val.replace(opts.att_regex[x].regex, '');
            }
          }
        } else {
          return val;
        }
      }
    });
    return(serialized_string);
  };
  
  $.fn.cable_menu = function(options){
    var $tree = $(this);
    var $wrapper = $("<div class='cable_menu_wrapper'></div>").insertAfter($tree);

    build_menu($tree, $wrapper, 0);
    
    $wrapper.find("li span.menu-title").click(function(){
      select_item($(this).parent(), $wrapper);
    });
    
     $wrapper.find("li span.menu-zoom").click(function(){
        zoom_item($(this).parent(), $wrapper);
      });
    
    update_tree($wrapper);
    $tree.remove();    
    
    $wrapper.find("ul").sortable(sortable_options);
    
    var $current_selection = $("<div id='selection'><strong>Current Selection:</strong><p>&nbsp;</p></div>").insertBefore($wrapper);
    // var $add1 = $("<div id='add-menu-tree1' class='actions'><a>Add Menu</a></div>").insertBefore($current_selection);
    // var $save1 = $("<div id='save-tree1' class='actions'><a>Save Tree</a></div>").insertBefore($current_selection);

    var $save = $("<div id='save-tree' class='actions'><a>Save Tree</a></div>").insertAfter($wrapper);
    var $add = $("<div id='add-menu-tree' class='actions'><a>Add Menu</a></div>").insertAfter($wrapper);

    var $form = $("<div id='add-menu-form' />").insertAfter($save);
    var $menu_details = $("<div id='menu-details' />").insertAfter($save);

    $save.click(function(){save_tree();}); 
    // $save1.click(function(){save_tree();}); 

    $add.click(function(){
      $("#add-menu-form").html("<img src='/images/cable/loader.gif' />");
      $("#add-menu-form").load("/admin/menus/new?parent_id="+parent_id, function(){
        $(this).dialog({
          modal: true,
          width: 600,
      resizable: false,
          title: "New Resource",
      draggable: false
        });
      });
    }); 
    // hash = unescape( window.location.hash).replace("#","")
    // selectable_item = $wrapper.find('li[title="'+hash+'"]');
    select_item( $wrapper.find('ul[menu="0"] li') )
    // if(selectable_item.length > 0) {
        // select_item( selectable_item, $wrapper )
    // }

    // $add1.click(function(){
    //       $("#add-menu-form").html("<img src='/images/cable/loader.gif' />");
    //       
    //       var get_string;
    //       
    //       if (parent_id > 0){
    //         get_string = "?parent_id="+parent_id;
    //       } else {
    //         get_string = "?parent_id=0";
    //       }
    //       
    //       $("#add-menu-form").load("/admin/menus/new"+get_string, function(){
    //         $(this).dialog({
    //           modal: true,
    //           width: 600,
    //       resizable: false,
    //           title: "New Resource",
    //       draggable: false
    //         });
    //       });
    //     });
    //    
    $("<hr />").insertAfter($wrapper);

  }

})(jQuery);
