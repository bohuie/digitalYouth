//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
//converted to js for now.

function show_message(inputId){
	var val = $('#'+inputId).val()
	if(val == "")
		$('#msg').html("<br>");
	else
		$('#msg').html(val);
}

$(document).ready(function() {show_message("msg-inpt");});