//Setup event tracking and timing
timer();
ahoy.trackClicks();
ahoy.trackSubmits();

$(document).on("page:change", function() {recordViewStart();}); //Handles page load effectively
$(document).on("page:before-change", function() {recordViewEnd();}); //Handles site-site link navigation
//window.onbeforeunload = unload(); // attempts to handle other types of page ends like a refresh or in some cases page closing

window.onbeforeunload = function (e) {
	unload();
};

//page view end
function recordViewEnd(){
	var pageTime = TimeMe.getTimeOnCurrentPageInSeconds();
	TimeMe.resetAllRecordedPageTimes(); //TimeMe likes to keep recording page times after a 'view end' so reset is required.
	ahoy.track("$view_end", {page: new Url().path, time: pageTime}); // Sometimes records a false 0 time, should be able to query view, view end in this case. (Generally happens with a refresh)
}

//page view start
function recordViewStart(){
	timer();
	ahoy.trackView();
}

function timer(){
	TimeMe.setIdleDurationInSeconds(60);
	TimeMe.setCurrentPageName(new Url().path);
	TimeMe.initialize();
}

function unload(){
	recordViewEnd();
//    for (var i=0;i<2000;i++){
//      console.log('buying some time to finish saving data'); 
//    };
}