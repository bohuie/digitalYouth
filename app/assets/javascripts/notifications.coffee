# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  return unless $(".notifications.index").length > 0
  $(window).scroll(() ->
  	checkScroll(15,'ajax-loading','/notifications');)
  $(window).unload(() ->
  	$(window).unbind();)

  elem = $('#refreshed');
  if(elem.val()=="0")
  	elem.val("1");
  else if(elem.val()=="1")
  	elem.val("0");		
  	location.reload();

  