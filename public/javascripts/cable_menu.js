(function($){    
  
  function save_tree(){
    $(".cable_menu li").each(function() {
      var $ul = $(this).data('childUl');
      if ($ul) $ul.appendTo(this);
    });
    var mylist = $('.cable_menu_wrapper > ul').serialize_list();
    $.post("/admin/menus/sort", mylist);
  }
  
  function select_item(item){
    var $this = $(item);
    $this.addClass('selected').data('childUl').css({
      left: $this.parent().position().left + $this.parent().width(),
      top: 0
    }).show();
    $this.siblings('.selected').each(deselect);
    var items = new Array();
    $("..cable_menu_wrapper .selected").removeClass("last");
    $("..cable_menu_wrapper .selected").each(function(){
      items.push($(this).text());
    });
    
    $(".current_selection").html("<strong>Current Selection:</strong>"+items.join(" &raquo; "));
    $(".cable_menu_wrapper .selected").last().addClass("last");
  }
  
  function deselect() {
    var $ul = $(this).removeClass('selected').data('childUl');
    if ($ul) {
      $ul.hide().find('li.selected').removeClass('selected').each(deselect);
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
    
    $(this).wrap("<div class='cable_menu_wrapper' />");
    $(this).addClass("cable_menu");
    $(".cable_menu li").each(function() {
      var $this = $(this), $ul = $this.children('ul');
      $this.data('childUl', $ul);
      if($ul.children().size()>0){
        $this.addClass("has-children");
      };
      $ul.attr("parent",$(this).attr("id"));
      $ul.addClass("cable_menu");
      $ul.hide().appendTo('.cable_menu_wrapper');
    }).click(function() {
      select_item(this);
    });

    var sortable_options = {
      connectWith: '.cable_menu_wrapper ul',
      appendTo: '.cable_menu_wrapper',
      helper: 'clone',
      stop: function(event, ui){
        select_item(ui.item[0]);
      },
      receive: function(event, ui) { 
        var this_id = $(ui.item[0]).attr("id");
        var child_id = $(event.target).attr("parent");
        
        var size = $(".cable_menu .selected").size()-1;
        
        console.log("Child ID:"+child_id);
        console.log("This ID:"+this_id);
        
        $(".cable_menu .selected").each(function(index){
          console.log(this_id + " - " + $(this).attr("id"));
          if(size > index ){
            if($(this).attr("id") == this_id){
              $(ui.sender).sortable('cancel');
            }
          }else{
            console.log("It's the last one. Do something slightly different.");
            if(child_id == this_id){
              $(ui.sender).sortable('cancel');
            }
          }
        });
      }
    };
    $(".cable_menu_wrapper").after("<div id='unfold'>Unfold</div>");
    $(".cable_menu_wrapper").before("<div class='current_selection'><strong>Current Selection:</strong></div>")
    $(".cable_menu_wrapper").after("<div id='unfolded'></div>");
    $(".cable_menu_wrapper ul").sortable(sortable_options);
    $("#unfold").click(save_tree);
  }

})(jQuery);
