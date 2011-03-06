(function($){    
  
  function save_tree(){
    $(".cable_menu_wrapper li").each(function() {
      console.log($(this).data()); 
      console.log("----");
    });
    var mylist = $('.cable_menu_wrapper > ul').serialize_list();
    console.log(mylist);
    // $.post("/admin/menus/sort", mylist);
  }
  
  function show_add_menu(item){
    $("#add-menu").remove();
    var $add = $("<li id='add-menu'>Add Menu &#8230;</li>").appendTo($(item));
    $add.click(function(){
      $("#dialog").remove();

      var id = $(item).attr("parent");      
      $add_dialog = $(("<div id='dialog'></div>")).load("/admin/menus/new?parent_id="+id).appendTo("body");
      
      $add_dialog.dialog({
        title: 'Add Menu Item',
  			height: 300,
  			width: 350,
  			modal: true,
  			buttons: {
  			  Cancel: function() {
  					$( this ).dialog( "close" );
  				},
  				Create: function() {
  				}
  			},
  			close: function() {
  			}
  		});
  		$add_dialog.dialog( "option", "title", 'Dialog Title' );
    })
  }
  
  function hide_add_menu(item){
    $("#add-menu").remove();
  }
  
  function update_breadcrumb(){
    var items = new Array();
    $(".cable_menu_wrapper .selected").removeClass("last");
    $(".cable_menu_wrapper .selected").each(function(){
      items.push($(this).text());
    });
    
    $("#selection p").html(items.join(" &raquo; "));
    $(".cable_menu_wrapper .selected").last().addClass("last");    
  }
  
  function select_item(item,wrapper){
    $item = $(item);
    id = $(item).attr("id");

    $child = $("[parent="+id+"]")
    
    if($child){
      $child.css({
        left: $item.parent().position().left + $item.parent().width()+3+$(".cable_menu_wrapper").scrollLeft(),
        top: 0
      }).show();      
    }
    
    $item.addClass("selected");
    $item.siblings('.selected').each(function(){
      deselect(this);
    });
    $child.children().each(function(){
      deselect(this);
    });
    
    $(wrapper).append($item.parent());
    update_breadcrumb();
  }
  
  function deselect(item) {
    var $item = $(item);
    $item.removeClass('selected');
    id = $item.attr("id");

    $child = $("[parent="+id+"]");

    $child.hide().find("li").each(function(){
      deselect(this);
    });
    
  }
  
  function explode(item, wrap){
    $wrap = $(wrap)
    $li = $(item);
    $ul = $li.children('ul');     
    console.log($li);
    if($ul.children().size() > 0){
      $cul = $("<ul/>").attr("parent", $li.attr("id")).addClass("cable_menu").appendTo($wrap);        
      $ul.children().each(function(){
        var $cli = $(this).clone();
        if($cli.children().size() > 0){
          $cli.addClass("has-children");
        }
        $cli.appendTo($cul);
        $cli.data("ChildUL",$ul);
        $cli.find("ul").remove();
      });
      $cul.hide();
    }
    
  }
  $.fn.serialize_list = function(options) {
    var defaults = {
      attributes: ['id', 'class'],
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
    var $wrap = $("<div class='cable_menu_wrapper'></div>").insertAfter($tree);
    
    $tree.find("li").each(function() {
      explode(this,$wrap);
    });
    // $tree.children("li").each(function(){
    //   explode(this,$wrap);
    // })
    
    
    $(".cable_menu li").click(function(){
      select_item(this, $wrap);
    });
    
    $tree.hide();
    
    
    var sortable_options = {
      items: "li:not(#add-menu)",
      connectWith: '.cable_menu_wrapper ul',
      appendTo: '.cable_menu_wrapper',
      helper: 'clone',
      placeholder: "ui-state-highlight",
      stop: function(event, ui){
        select_item(ui.item[0]);
      },
      update: function(event, ui) {
        
      },
      receive: function(event, ui) { 
        var this_id = $(ui.item[0]).attr("id");
        var child_id = $(event.target).attr("parent");
        var size = $(".cable_menu .selected").size()-1;
        
        $(".cable_menu .selected").each(function(index){
          if(size > index ){
            if($(this).attr("id") == this_id){
              $(ui.sender).sortable('cancel');
            }
          }else{
            if(child_id == this_id){
              $(ui.sender).sortable('cancel');
            }
          }
        });
      }
    };
    
    $wrap.find("ul").sortable(sortable_options);
    $wrap.find("ul").mouseenter(function() {
      show_add_menu(this);
     }).mouseleave(function(){
      hide_add_menu(this);       
     });
    $wrap.before("<div id='selection'><strong>Current Selection:</strong><p>&nbsp;</p></div>");
    $wrap.after("<div id='save_tree'><a class='button'>Save Tree</a></div>");
    $("#save_tree").click(function(){
      save_tree();
    });
  }

})(jQuery);
