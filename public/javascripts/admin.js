$(document).ready(function(){
  $('.wymeditor').wymeditor({
		classesItems: [
			{'name': 'left', 'title': 'left'},
			{'name': 'right', 'title': 'right'}
		],
		editorStyles: [
			{'name': '.left', 'css': 'float:right;'},
			{'name': '.right', 'css': 'float:left;'},
			{'name': 'p', 'css': 'overflow:auto;'},
		],
		postInit: function(wym) {
			$(wym._box).find(wym._options.containersSelector).removeClass('wym_dropdown').addClass('wym_panel').find('h2 > span').remove();
			$(wym._box).find(wym._options.iframeSelector).css('height', '250px');
			wym.initMediaBrowser({url: '/attachable_assets'});
			wym.fullscreen();   
			// wym.embed();
		}   
	});
  $('.button').button();
  $('.disabled-button').button({disabled: true});
	$('.yes_no :checkbox').iphoneStyle({
	  checkedLabel: 'YES',
	  uncheckedLabel: 'NO'
	});
});
