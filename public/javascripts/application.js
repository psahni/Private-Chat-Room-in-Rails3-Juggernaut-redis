$.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})
//-------------------------------------------------------------------
$(function(){
  $('textarea').keypress(function(e){
  if(e.keyCode == 13 && !message_length($(this))){
    $(this).parent().submit();
   }
 });
//-------------------------------------------------------------------
$("form#chat_box").submit(function(e){
	var textarea = $(this).children('textarea');
  if(message_length(textarea)){
     return false;
  }
  else{
		inject_message(textarea);
    return true;
  }
});
//-------------------------------------------------------------------	
$("form#chat_box").bind("ajax:success", function(){
   $(this)[0].reset();
  });
});

//-------------------------------------------------------------------
function message_length(element){
	return (element.val().trim().length == 0)
}

//-------------------------------------------------------------------
function inject_message(msg_element){
 var element = $('<li/>').addClass('items');
 element.text(username+":"+" "+msg_element.val());
 $('#message').append(element);
}
