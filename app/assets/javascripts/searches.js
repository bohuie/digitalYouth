//Has been changed to javascript for now
//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

// Need to see if this still works
 $(document).on("page:change", function() {
    if (!($(".searches.index").length > 0)) {return;}
    $(window).scroll(function() {checkScroll(15, 'ajax-loading', window.location.href);});
    $(window).unload(function() {$(window).unbind();});

    $( document ).ready(function() {
        console.log($('#results').length);
        if($('#total-results').val()<=($('#results').length)){
          can_request = false;
          $('#load-more').hide();
        }
    });
    
  });

function hideUnHide(hide,unhide){
	$("#"+hide).hide();
	$("#"+unhide).show();
}

function filterInputChange(){
	
}

/* Old coffee script
$(document).on "page:change", ->
  return unless $(".searches.index").length > 0

  $(window).scroll(() ->
  	checkScroll(15,'ajax-loading',window.location.href);)
  $(window).unload(() ->
  	$(window).unbind();)
  ""
*/