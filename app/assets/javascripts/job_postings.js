//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
//Converted to Javascript for now

function remove_posting_skill(id){
  if ($('body').hasClass('job_postings')){
    $('#job-skill-destroy-'+id).val(true);
    $('#job-posting-skill-'+id).fadeOut(100);
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

function add_job_posting_skill_fields(association, content){
  if ($('body').hasClass('job_postings')){
    var skills = 0;
    $('#job-skills').children().each(function(){if(this.id.includes("job-posting-skill-")) skills++;});
    var new_id = skills + 1;
    var regexp = new RegExp("new_" + association, "g");
    $('#job-skills').append(content.replace(regexp, new_id));
  }
}

function set_date(){
  if ($('.job_postings.new').length > 0 && $('#open-date').val() == ""){
    var today = new Date();
    var day = today.getDate();
    var month = today.getMonth()+1;
    var year = today.getFullYear();
    if(day<10) {day='0'+day;}
    if(month<10) {month='0'+month;}
    $('#open-date').val(year+'-'+month+'-'+day);
  }
}

function display_loading(){
  $('#refresh-progress').show();
}

$( document ).ready(function() {set_date();});
$( document ).on('page:load',function() {set_date();});

