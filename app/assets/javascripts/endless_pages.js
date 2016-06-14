//For other endless scrolling
var curr_page = 1;
var can_request = true; 

//For notifications
var curr_notif_page = 1;
var can_request_notif = true;

//Custom endless scrolling for notifications
function checkNotificationScroll(){
	if(distToBottomOfDiv('notif-list') < 5 && can_request_notif){
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
}

//Generic endless scrolling for the page
function checkScroll(dist,loading_id,url){
	if(distToBottomOfPage() < dist && can_request)
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

//Computes distance to bottom of a scrollable div
function distToBottomOfDiv(div_id){
	var div = $('#'+div_id);
	return (div.prop('scrollHeight') - (div.scrollTop() + div.height()));
}

//Compute distance to bottom of page
function distToBottomOfPage(){
	var pageHeight = Math.max(document.body.scrollHeight, document.body.offsetHeight);
	return (pageHeight - (div.scrollTop() + div.height()));
}