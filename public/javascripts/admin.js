$(document).ready(function(){
  $().ready(function() {
		$('textarea.tinymce').tinymce({
      script_url : '/javascripts/tinymce/tiny_mce.js',
      theme : "advanced",
      height : "600px",
      plugins : "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,advlist",
      theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,formatselect,cut,copy,paste,pastetext,pasteword",
      theme_advanced_buttons2 : "search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,preview",
      theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,media|,fullscreen",
      theme_advanced_toolbar_location : "top",
      theme_advanced_toolbar_align : "left",
      theme_advanced_statusbar_location : "bottom",
      theme_advanced_resizing : true
    });
  });
  $('.disabled-button').button({disabled: true});
  $('.yes_no :checkbox').iphoneStyle({
    checkedLabel: 'YES',
    uncheckedLabel: 'NO'
  });
});
