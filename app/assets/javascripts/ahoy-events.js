$(document).ready(function() {
	ahoy.trackClicks();
	ahoy.trackSubmits();
	var pageLoad;
});

$(document).on("page:change", function() {
	var dt = new Date;
	pageLoad = Date.UTC(dt.getFullYear(),dt.getMonth(),dt.getDate(),dt.getHours(),dt.getMinutes(),dt.getSeconds(),dt.getMilliseconds());
	ahoy.trackView();
});

$(document).on("page:before-change", function() {record_view();});

 function record_view(){
 	var dt = new Date;
	var pageUnload = Date.UTC(dt.getFullYear(),dt.getMonth(),dt.getDate(),dt.getHours(),dt.getMinutes(),dt.getSeconds(),dt.getMilliseconds());
	var url = new Url; //Requires domurl.min.js
	var path = url.path;
	ahoy.track("$page_view", {page: path, time: pageUnload-pageLoad});
 }