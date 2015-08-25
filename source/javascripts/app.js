//= require "jquery"

$(document).ready(function() {
  $('.question').click(function(event){
    var isQuestion = $(event.target).is('.question');
    if(isQuestion){ //make sure I am a question element
        $('.answer', this).toggle(); // p00f
    }
  });
});
