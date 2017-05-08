//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

//Switched to js for now
function buttonOpac(button)
{
	button.style.opacity=1.0;
}
function buttonRevOpac(button)
{
	button.style.opacity=0.6;
}
function rendering(toRender)
{					
	if(toRender=='references')
	{			
		document.getElementById("references").style.display="inline";

		document.getElementById("survey-table").style.display="none";
		document.getElementById("projects").style.display="none";
		document.getElementById("skills").style.display="none";	
	}
	else if(toRender=='projects')
	{
		document.getElementById("projects").style.display="inline";

		document.getElementById("survey-table").style.display="none";
		document.getElementById("references").style.display="none";
		document.getElementById("skills").style.display="none";
	}
	else if(toRender=='skills')
	{
		document.getElementById("skills").style.display="inline";

		document.getElementById("survey-table").style.display="none";
		document.getElementById("references").style.display="none";
		document.getElementById("projects").style.display="none";
	}
	else if(toRender=='surveys')
	{
		document.getElementById("survey-table").style.display="inline";

		document.getElementById("references").style.display="none";
		document.getElementById("projects").style.display="none";
		document.getElementById("skills").style.display="none";
	}
	else
	{
		document.getElementById("survey-table").style.display="none";
		document.getElementById("references").style.display="none";
		document.getElementById("projects").style.display="none";
		document.getElementById("skills").style.display="none";
		//needs edited if more to be added
		if(toRender=='job-postings')
		{
			document.getElementById("job-postings").style.display="inline";
		}
	}
}

function setHomeTab(value, url)
{
	if (typeof(value)==='undefined') value = "surveys";
	
	if (typeof(url)==='undefined'){

	$.ajax({
		url: '/users/home_tab',
		data: {home_tab: value},
		type: 'post',
		beforeSend: function(jqXHR, settings) {
        	jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
    	}
		})
		.done(function(response) {
  			// Do something with the response
		})
		.fail(function(error) {
  			// Do something with the error
		});
	}
	else {
		$.ajax({
		url: '/users/home_tab',
		data: {
			home_tab: value,
			redirect: url
		},
		dataType: "script",
		type: 'post',
		beforeSend: function(jqXHR, settings) {
        	jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
    	}
		})
		.done(function(response) {
  			// Do something with the response
		})
		.fail(function(error) {
  			// Do something with the error
		});
	}
}

function setNavTab(value, url)
{
	if (typeof(value)==='undefined') value = "surveys";

	if (typeof(url)==='undefined'){
		$.ajax({
			url: '/users/nav_tab',
			data: {nav_tab: value},
			type: 'post',
			beforeSend: function(jqXHR, settings) {
        		jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
    		}
		})
		.done(function(response) {
  			// Do something with the response
		})
		.fail(function(error) {
  			// Do something with the error
		});
	}
	else {
		$.ajax({
			url: '/users/nav_tab',
			data: {
				nav_tab: value,
				redirect: url
			},
			dataType: "script",
			type: 'post',
			beforeSend: function(jqXHR, settings) {
        		jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
    		}
		})
		.done(function(response) {
  			// Do something with the response
		})
		.fail(function(error) {
  			// Do something with the error
		});
	}
}

function add_announcement_fields(association, content){
    var announcements = 0;
    $('#announcement-messages').children().each(function(){if(this.id.includes("announcement-")) announcements++;});
    var new_id = announcements;
    var regexp = new RegExp("resource_links", "g");
    $('#announcement-messages').append(content.replace(regexp, new_id));
}

function remove_announcement(id){
	$('#announcement-destroy-'+id).val(true);
	$('#announcement-'+id).fadeOut(100);
	$('#announcement-message-'+id).removeAttr('required');
}

function add_resource_link_fields(association, content){
    var resource_links = 0;
    $('#links').children().each(function(){if(this.id.includes("resource-link-")) resource_links++;});
    var new_id = resource_links;
    var regexp = new RegExp("resource_links", "g");
    $('#links').append(content.replace(regexp, new_id));
}

function remove_resource_link(id){
	$('#resource-link-destroy-'+id).val(true);
	$('#resource-link-md-destroy-'+id).val(true);
	$('#resource-link-'+id).fadeOut(100);
	$('#hr-'+id).fadeOut(100);
	$('#description-'+id).removeAttr('required');
	$('#link-'+id).removeAttr('required');
}
