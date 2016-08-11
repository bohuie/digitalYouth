//Has been changed to javascript for now
//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

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

function hideUnHide(hide,unhide){
	$("#"+hide).hide();
	$("#"+unhide).show();
}

function filterInputChange(id,key,filter){
  var filt_val = getURLParameter('f');
  var val = urlFormat($('#'+id).val());
  filt_val = urlFormat(appendReplace(filter,filt_val));

  var url = setGetParameter('f',filt_val);
  setGetParameter(key,val,true,url);
}

//From Stackoverflow
function getURLParameter(param_name) {
  return decodeURIComponent((new RegExp('[?|&]' + param_name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search) || [null, ''])[1].replace(/\+/g, '%20')) || null;
}

//From Stackoverflow
function setGetParameter(paramName, paramValue,redir=false, url=window.location.href){
    var hash = location.hash;
    url = url.replace(hash, '');
    if (url.indexOf(paramName + "=") >= 0){
        var prefix = url.substring(0, url.indexOf(paramName));
        var suffix = url.substring(url.indexOf(paramName));
        suffix = suffix.substring(suffix.indexOf("=") + 1);
        suffix = (suffix.indexOf("&") >= 0) ? suffix.substring(suffix.indexOf("&")) : "";
        url = prefix + paramName + "=" + paramValue + suffix;
    }
    else{
    if (url.indexOf("?") < 0)
        url += "?" + paramName + "=" + paramValue;
    else
        url += "&" + paramName + "=" + paramValue;
    }
    if(redir){
      console.log("url:"+url);
      window.location.href = url + hash;
    }
    else
      return url + hash;
}

function appendReplace(strIN,str){
  if(str == null)
    return strIN;
  else if(str.includes(strIN))
    return str;
  else
    return str+"%2C"+strIN;
}

function urlFormat(str){
  str = encodeURI(str);
  str = str.replace("%20",'+');
  str = str.replace(',',"%2C");
  return str;
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