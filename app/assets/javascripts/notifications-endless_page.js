var curr_notif_page = 1;
var can_request_notif = true;

function checkNotificationScroll(){
	if(distToBottomOfNotif() < 10 && can_request_notif){
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

function distToBottomOfNotif(){
	var div = $('#notif-list');
	return (div.prop('scrollHeight') - (div.scrollTop() + div.height()));
}