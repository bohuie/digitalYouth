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
debugger
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

