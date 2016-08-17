//Setup event tracking
$(document).ready(function() {
	ahoy.trackClicks(); //Not working
	ahoy.trackSubmits(); //Not working
	var pageLoad;
});

//On page change and before change track events
$(document).on("page:change", function() {recordViewStart();});
$(document).on("page:before-change", function() {recordViewEnd();});
$(window).bind('beforeunload',function(){recordViewEnd();}); //Works for refreshes, doesn't work for closing or nav away
//$(window).unload(function(){recordViewEnd();}); 

//page view end
function recordViewEnd(){
	var dt = new Date;
	var pageUnload = Date.UTC(dt.getFullYear(),dt.getMonth(),dt.getDate(),dt.getHours(),dt.getMinutes(),dt.getSeconds(),dt.getMilliseconds());
	var url = new Url; //Requires domurl.min.js
	var path = url.path;
	ahoy.track("$view_end", {page: path, time: pageUnload-pageLoad});
}

//page view start
function recordViewStart(){
 	var dt = new Date;
	pageLoad = Date.UTC(dt.getFullYear(),dt.getMonth(),dt.getDate(),dt.getHours(),dt.getMinutes(),dt.getSeconds(),dt.getMilliseconds());
	ahoy.trackView();
}