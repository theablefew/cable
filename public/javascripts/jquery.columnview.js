/**
 * jquery.columnview-1.2.js
 *
 * Created by Chris Yates on 2009-02-26.
 * http://christianyates.com
 * Copyright 2009 Christian Yates and ASU Mars Space Flight Facility. All rights reserved.
 *
 * Supported under jQuery 1.2.x or later
 * Keyboard navigation supported under 1.3.x or later
 * 
 * Dual licensed under MIT and GPL.
 */

(function($){
  
  function hide_all_child_menus(){
    $(".child_menu").hide();
  }
  
  function show_child(item){
    var child_menu = $("[parent="+item.attr("id")+"]");
    child_menu.show();
  }
  
  function show_parents(item){
    var parent_menu = $(item).parent();

    parent_menu.show();
    if(parent_menu.attr("parent")){
      show_parents(parent_menu);
    }
    
  }
  
  function select_item(item){
    
    $(".selected").removeClass("selected");
    item.addClass("selected");
    hide_all_child_menus();
    show_child(item);
    show_parents(item);
    
  }
  
  $.fn.columnview = function(options){
    var settings = $.extend({}, $.fn.columnview.defaults, options);  
    $("#outer li").each(function() {

      var $this = $(this);
      var parent_id = $(this).attr("id")
      var $ul = $(this).children('ul');
      
      $(this).data('child', $ul);
      
      $ul.hide();
      $ul.appendTo('#outer');
      $ul.attr("parent", parent_id);
      $ul.addClass("child_menu");
      
    }).click(function() {
      select_item($(this));
    });
    
    // attach sortable out here so that it hits all the ULs
    var sortOpts = {
      
      connectWith: '#outer ul',
      appendTo: '#outer',
      helper: 'clone',
      stop: function(event, ui){
      },
      receive: function(event, ui) { 
        
        var this_id = $(ui.item[0]).attr("id");
        var child_id = $(event.target).attr("parent");
        
        if (this_id == child_id) { 
          $(ui.sender).sortable('cancel'); 
        }
      } 
    };
    
    $("#outer ul").sortable(sortOpts);
    
  };

})(jQuery);
