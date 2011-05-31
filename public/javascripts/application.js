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
//-------------------------------------------------------------------
var CHANNEL_ID = null;
$(function(){
  var box = null;
  $('li').bind('click', function(){
    var online_user_name = $(this).text(); 
    $.post('/channels', {sender_id: current_user_id, receiver_id: $(this).attr('id').replace(/user_/, '')}, function(cid){
        CHANNEL_ID = cid; //data is channel id to which to user has to subscribe
        var jug = new Juggernaut;
        jug.subscribe('channel'+CHANNEL_ID, function(data){     
        data = data.split(':');
        online_user_name = data[0];
        message = data[1];
        $("#chat_div").chatbox("option", "boxManager").addMsg(online_user_name, message);          
        });
    }, "html")//.success(function(data){ alert(data)}); 
       manage_chat_box(box, online_user_name, username);
  });
});

//-------------------------------------------------------------------

function manage_chat_box(box, online_user_name, receiver_name){
  var box = box;
  if(box){
     box.chatbox("option", "boxManager").toggleBox();
   }
   else{
     box = $("#chat_div").chatbox({id: username,
             user: {key: 'value'},
             title: online_user_name,
             messageSent: function(id, user, message){
                $("#chat_div").chatbox("option", "boxManager").addMsg(id, message);
                $.post('/messages', {channel_id: CHANNEL_ID, body: message}, function(){});
             }});
   }
} 
