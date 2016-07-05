//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
//Converted to Javascript for now

function remove_posting_skill(id){
	$('#'+id+'-destroy').val(true);
	$('#'+id).fadeOut(100);
}

var cache = {};
function skill_autocomplete(id){
	$("#skill-name-"+id).autocomplete({
		minLength: 2,
      	source: function( request, response ) {
        var term = request.term;
        if ( term in cache ) {
          response( cache[ term ] );
          return;
        }
 
        $.getJSON( '/job_postings/skill_autocomplete.json', request, function( data, status, xhr ) {
          cache[ term ] = data;
          response( data );
        });
    }
  });
}
