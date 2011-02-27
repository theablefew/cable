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

  function deselect() {
    var $ul = $(this).removeClass('selected').data('child');
    if ($ul) {
      $ul.find('li.selected').removeClass('selected').each(deselect);
    }
  }
  
  function select_item(){
  }
  
  $.fn.columnview = function(options){
    var settings = $.extend({}, $.fn.columnview.defaults, options);
    $("#outer li").each(function() {      
      
      var $this = $(this)
      var $ul = $this.children('ul');
      
      $this.data('child', $ul);
      
      // hide it
      $ul.hide();
      
      // Append it to the outer div
      $ul.appendTo('#outer');
      
      // set it's parent attribute
      $ul.attr("parent", $this.attr("id"));
      
    }).click(function() {
      
      var $this = $(this);
      
      // Make it selected
      $this.addClass('selected');
      
      
      // left
      var this_left = $this.parent().offset().left;
      var panel_left = $this.parent().parent().offset().left;
      var panel_scroll_left = $this.parent().parent().scrollLeft();
      var left = (this_left-panel_left)+panel_scroll_left
      var width = $this.parent().width();
      
      $this.data('child').css({
        left: left + width,
        top: 0
      });
      
      $this.data('child').show();
      $this.siblings('.selected').each(deselect);
      
    });
    
    // attach sortable out here so that it hits all the ULs
    var sortOpts = {
      connectWith: '#outer ul',
      containment: '#outer',
      appendTo: '#outer',
      helper: 'clone',
      stop: function(event, ui){
        var id = $(ui.item[0]).attr("id");
        var $this = $(this);
        $this.siblings('.selected').each(deselect);
      },
      receive: function(event, ui) { 
        var id = $(ui.item[0]).attr("id");
        var child_id = $(event.target).attr("parent");        
        if (id == child_id) { 
          $(ui.sender).sortable('cancel'); 
        }
      }
    };
    
    $("#outer ul").sortable(sortOpts);
    
  };

})(jQuery);