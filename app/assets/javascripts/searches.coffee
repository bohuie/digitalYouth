# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  return unless $(".searches.index").length > 0

  $(window).scroll(() ->
  	checkScroll(15,'ajax-loading',window.location.href);)
  $(window).unload(() ->
  	$(window).unbind();)