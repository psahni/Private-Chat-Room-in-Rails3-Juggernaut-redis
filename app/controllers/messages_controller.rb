class MessagesController < ApplicationController
  
  
  def create
    @message = Message.new
    @message.body      = params['body']
    @message.channel_id = params['channel_id']
    @message.save!
    publish_message
  rescue
    logger.error("---"+ $!.message + " Message has not been saved----")    
  end
  
  
#----------------------------------------private---------------------------------------------------------
  
  private
  
  def publish_message
    @sender_channel   = Channel.find_by_channel_id(@message.channel_id)
    @receiver_channel = Channel.find_by_receiver_id_and_sender_id(current_user.id, @sender_channel.receiver_id)
    #Juggernaut.publish(['channel'+ "#{ @sender_channel.channel_id }", "channel" + "#{ @receiver_channel.channel_id }"], text_message)
    Juggernaut.publish("channel" + "#{ @receiver_channel.channel_id }", text_message)
    render :nothing => true
  end
 
  def text_message
    "#{ current_user.channel_name }: #{ @message.body }"
  end
  
end
