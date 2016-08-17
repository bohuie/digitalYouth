//Has been changed to javascript for now
//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

/*
  On page load:
    Setup endless scrolling events
    Set search-type select to value
    Restricts endless scrolling if there isn't anymore to load.
*/
 $(document).on("page:change", function() {
    if (!($(".searches.index").length > 0)) {return;}
    $(window).scroll(function() {checkScroll(15, 'ajax-loading', window.location.href);});
    $(window).unload(function() {$(window).unbind();});

    $( document ).ready(function() {
      $('#type-select').val(getURLParameter('t'));
      if($('#total-results').val()<=($('#results').length)){
        can_request = false;
        $('#load-more').hide();
      }
    });
  });

//Hides the first element, shows the second
function hideUnHide(hide,unhide){
	$("#"+hide).hide();
	$("#"+unhide).show();
}

//Adds filter, and filter value to the url from the input and redirects
function filterInputChange(id,key,filter){
  var val = $('#'+id).val();
  if(val != ""){
    var url_obj = new Url; //Requires url.min.js
    var filters = url_obj.query['f'];
    url_obj.query['f'] = appendReplace(filter,filters);
    url_obj.query[key] = val;
    window.location.href = url_obj.toString();
  }
}

//Appends or keeps current string
function appendReplace(strIN,str){
  if(str == null)
    return strIN;
  else if(str.includes(strIN))
    return str;
  else if (str === "")
    return strIN;
  else
    return str+","+strIN;
}

//Function quickly retrieves a get parameter (from Stackoverflow)
function getURLParameter(param) {return decodeURIComponent((new RegExp('[?|&]'+param+'='+'([^&;]+?)(&|#|;|$)').exec(location.search)||[null,''])[1].replace(/\+/g,'%20'))||null;}