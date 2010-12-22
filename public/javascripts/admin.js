$(document).ready(function(){
  
  $('.button').button();
  $('.disabled-button').button({disabled: true});
  $('.yes_no :checkbox').iphoneStyle({
    checkedLabel: 'YES',
    uncheckedLabel: 'NO'
  });
});
