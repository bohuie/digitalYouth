//For other endless scrolling
var curr_page = 1; //Current page for pagination
var can_request = true; //Boolean to limit the ability to make more requests

/*	Generic endless scrolling function for the page.
	Bind a call to this function to the scroll action
	of a page to enable endless scrolling js functions.

	dist: the distance from the bottom of the page
   		  that you want the AJAX request to execute

	loading_id: the ID of the element that will display
   			    to the user that something is loading.
   			    When the new elements are added with the 
   			    action's JS the element must be hidden.

	url: The path to the action that will process the
		 AJAX request. (The action must respond_to: js)

*/
function checkScroll(dist,loading_id,url){
	if(distToBottomOfPage() < dist && can_request)
		makeAjaxRequest(loading_id,url);
}

function makeAjaxRequest(loading_id,url){
	curr_page++;
	$('#'+loading_id).css("visibility","visible");
	$('#'+loading_id).show();
	can_request = false;
		
	$.ajax({
	    type : 'get',
	    url : url,
	    data : "page=" + curr_page,
	    dataType : 'script',
	    async : true
	});
}

//For notifications
var curr_notif_page = 1;
var can_request_notif = true;

//Custom endless scrolling for notifications
function checkNotificationScroll(){
	if(distToBottomOfDiv('notif-list') < 5 && can_request_notif)
		makeNotificationRequest();
		
}

function makeNotificationRequest(){
	curr_notif_page++;
	$('#notif-loading').css("visibility","visible");
	can_request_notif = false;
	
	$.ajax({
	    type : 'get',
	    url : '/notifications/show',
	    data : "page=" + curr_notif_page,    
	    dataType : 'script',
	    async : true
	});
}


//Computes distance to bottom of a scrollable div
function distToBottomOfDiv(div_id){
	var div = $('#'+div_id);
	return (div.prop('scrollHeight') - (div.scrollTop() + div.height()));
}

//Compute distance to bottom of page
function distToBottomOfPage(){
	var pageHeight = Math.max(document.body.scrollHeight, document.body.offsetHeight);
	return (pageHeight - (window.pageYOffset + self.innerHeight));
}