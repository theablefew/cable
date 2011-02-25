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
  function probe_tree(tree){
    
    $(tree).children().each(function(index){

      if($(this).is("ul")){
        o1 = $('.columnview').offset();
        o2 = $(this).parent().offset();
        dy = o1.top - o2.top;
        $(this).css({"top":dy});
        $(this).addClass("level");
        $(this).sortable({
          connectWith : ".level"
        })
      }
      
      if($(this).is("li")){
        $(this).addClass("level_wrapper");
      }      
    });
  }
  function make_active(item){
    $(item).parentsUntil(".columview").addClass("active");
  }
  
  $.fn.columnview = function(options){
    var settings = $.extend({}, $.fn.columnview.defaults, options);

    probe_tree(this, 0);
    
    var key_event = $.browser.mozilla ? 'keypress' : 'keydown';
    
    $(this).bind("click " + key_event, function(event){

      if ($(event.target).is("a,span")) {
        if ($(event.target).is("span")){
          var self = $(event.target).parent();
        }else {
          var self = event.target;          
        }
        
        
        self.focus();
        
        var container = $(self).parents('.containerobj');
        
        // Handle clicks
        if (event.type == "click"){
          probe_tree($(self).parent());
          $(".active").removeClass("active");
          $(".targeted").removeClass("targeted");
          $(self).addClass("targeted");
          make_active(self);
          
        }
      }
    });
  };
  


  $.fn.columnview.defaults = {
    multi: false,     // Allow multiple selections
    preview: false,   // Handler for preview pane
    fixedwidth: false,// Use fixed width columns
    onchange: false   // Handler for selection change
  };



})(jQuery);