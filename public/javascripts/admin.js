$(document).ready(function(){
  $('.sortable-table').tablesorter();
  // $('.rich_editor').tinymce({
  //   script_url : '/javascripts/tinymce/tiny_mce.js',
  //   theme : "advanced",
  //   plugins : "pdw,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,advlist",
  //   theme_advanced_buttons1 : "pdw_toggle,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,formatselect,cut,copy,paste,pastetext,pasteword",
  //   theme_advanced_buttons2 : "search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,preview",
  //   theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,media,|,fullscreen",
  //   theme_advanced_toolbar_location : "top",
  //   theme_advanced_toolbar_align : "left",
  //   theme_advanced_statusbar_location : "bottom",
  //   theme_advanced_resizing : true,
  //   theme_advanced_resize_horizontal : false,
  //   pdw_toggle_on : 1,
  //   pdw_toggle_toolbars : "2,3",
  //   content_css : "/stylesheets/tinymce/custom_rich_editor.css"
  // });

  $('.disabled-button').button({disabled: true});
  
  $(".collapsible ol").hide();
  $(".collapsible legend").click(function(){
    $(this).nextAll("ol").slideToggle(500);
    $(this).parent().toggleClass("open");
  });
  
  $(".tabs").tabs({fx: { height: 'toggle'}});
  
  $(".collapsible legend").append(" <span class='expand'>Expand</span> <span class='close'>Close</span>");
  $(".collapsible legend").css({"cursor":"pointer"});
  $(".selected").last().addClass("last");
});
