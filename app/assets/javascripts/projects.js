//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/


function remove_project_skill(id){
  if ($('body').hasClass('users')){
	 $('#project-skill-destroy-'+id).val(true);
	 $('#project-skill-'+id).fadeOut(100);
  }
}

var cache = {};
function skill_autocomplete(id){
  console.log("AutoComplete");
	$("#skill-name-"+id).autocomplete({
		    minLength: 2,
      	source: function(request, response){
        var term = request.term.toLowerCase();
        if (term in cache){
          response(cache[term].slice(0, 4));
          return;
        }
 
        $.getJSON('/skills/autocomplete.json', request, function(data, status, xhr){
          cache[term] = data;
          response(data.slice(0, 4));
        }); 
    }
  });
  $('.ui-helper-hidden-accessible').hide();
}

function add_project_skill_fields(association, content){
  if ($('body').hasClass('users')){
    var skills = 0;
    $('#project-skills').children().each(function(){if(this.id.includes("project-skill-")) skills++;});
    var new_id = skills + 1;
    var regexp = new RegExp("new_" + association, "g");
    $('#project-skills').append(content.replace(regexp, new_id));
  }
}


function display_loading(){
  $('#refresh-progress').show();
}
