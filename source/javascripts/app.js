//= require "jquery"

$(document).ready(function() {
  // hide all answers on page
  $('.answer').hide();
  // toggle for answer when clicked
  $('.question').click(function(event){
    $('.answer', this).toggle();
  });
});
