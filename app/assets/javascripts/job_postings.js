//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
//Converted to Javascript for now

function remove_posting_skill(id){
	$('#job-skill-destroy-'+id).val(true);
	$('#job-posting-skill-'+id).fadeOut(100);
}

var cache = {};
function skill_autocomplete(id){
  console.log("AutoComplete");
	$("#skill-name-"+id).autocomplete({
		    minLength: 2,
      	source: function(request, response){
        var term = request.term.toLowerCase();
        if (term in cache){
          response(cache[term]);
          return;
        }
 
        $.getJSON('/skills/autocomplete.json', request, function(data, status, xhr){
          cache[term] = data;
          response(data);
        }); 
    }
  });
  $('.ui-helper-hidden-accessible').hide();
}

function add_fields(association, content){
  var skills = 0;
  $('#job-skills').children().each(function(){if(this.id.includes("job-posting-skill-")) skills++;});
  var new_id = skills + 1;
  var regexp = new RegExp("new_" + association, "g");
  $('#job-skills').append(content.replace(regexp, new_id));
}