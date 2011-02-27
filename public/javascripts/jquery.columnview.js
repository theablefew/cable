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
  
  function position_menu(item){
    console.log("Position Menu");
    
    var $this = item;
    
    var this_left = $this.parent().offset().left;
    var panel_left = $this.parent().parent().offset().left;
    var panel_scroll_left = $this.parent().parent().scrollLeft();
    var left = (this_left-panel_left)+panel_scroll_left
    var width = $this.parent().width();
    
    $this.data('child').css({
      left: left + width,
      top: 0
    });
  }
  
  
  function select_item(item){
    console.log("Select Item");
    console.log("Remove all selected");
    
    $(".selected").removeClass("selected");
    $(".child_menu").hide();
    
    // Make it selected
    item.addClass("selected");
    item.parent().show();
    
    console.log("Find the child menu "+item.attr("child")+" and show it");
    $("#"+item.attr("child")).show();
    
    position_menu(item);
  }
  
  $.fn.columnview = function(options){
    var settings = $.extend({}, $.fn.columnview.defaults, options);  
    $("#outer li").each(function() {
      
      var $this = $(this);
      var $ul = $(this).children('ul');
      
      $(this).data('child', $ul);
      
      $ul.hide();
      $ul.appendTo('#outer');
      
      $ul.attr("id", "child_of_"+$(this).attr("id"));
      $ul.addClass("child_menu");      

      $(this).attr("child", $ul.attr("id"));

      
    }).click(function() {
      select_item($(this));
    });
    
    // attach sortable out here so that it hits all the ULs
    var sortOpts = {
      
      connectWith: '#outer ul',
      containment: '#outer',
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