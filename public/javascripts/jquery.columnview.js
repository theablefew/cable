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
  
  function unfold(){

    $("#outer ul").sortable('destroy').show();
    $("#outer li").each(function() {
      var $ul = $(this).data('childUl');
      if ($ul) $ul.appendTo(this);
    });
    $("#outer > ul").appendTo("#unfolded");

    function walkIds($ul) {
      var obj = {};
      var children = $ul.children('li');
      children.each(function() {
        obj[this.id] = walkIds($(this).children('ul'));
      });
      
      return obj;
    }
    var idMap = walkIds($('#unfolded > ul'));
  }

  function select_item(item){
    var $this = $(item);
    $this.addClass('selected').data('childUl').css({
      left: $this.parent().position().left + $this.parent().width(),
      top: 0
    }).show();
    $this.siblings('.selected').each(deselect);
    var the_text = ""
    $("#outer .selected").each(function(){
      the_text += $(this).text();
      the_text += " &raquo; "
    });
    $("#thecurrent").html("Current Selection &raquo;"+the_text);
  }
    
  function deselect() {
    var $ul = $(this).removeClass('selected').data('childUl');
    if ($ul) {
      $ul.hide().find('li.selected').removeClass('selected').each(deselect);
    }
  }

  $.fn.columnview = function(options){
    var idCounter = 0;
    $("#outer li").each(function() {
      var $this = $(this), $ul = $this.children('ul');
      // $this.attr('id', 'li'+(idCounter++));
      $this.data('childUl', $ul);
      if($ul.children().size()>0){
        $this.addClass("has-children");
      };
      $ul.attr("parent",$(this).attr("id"));
      $ul.hide().appendTo('#outer');
    }).click(function() {
      select_item(this);
    });

    var sortable_options = {
      connectWith: '#outer ul',
      containment: '#outer',
      appendTo: '#outer',
      helper: 'clone',
      stop: function(event, ui){
        select_item(ui.item[0]);
      },
      receive: function(event, ui) { 
        var this_id = $(ui.item[0]).attr("id");
        var child_id = $(event.target).attr("parent");
        $("#outer .selected").each(function(){
          if($(this).attr("id") == this_id)
          $(ui.sender).sortable('cancel');
        });
        // if (this_id == child_id) {
        //   $(ui.sender).sortable('cancel'); 
        //   alert("Can't drag parent into itself.");          
        // }
      }
    };
    $("#outer").after("<div id='unfold'>Unfold</div>");
    $("#outer").after("<div id='unfolded'></div>");
    $("#outer ul").sortable(sortable_options);
    $("#unfold").click(unfold);
  }
})(jQuery);
