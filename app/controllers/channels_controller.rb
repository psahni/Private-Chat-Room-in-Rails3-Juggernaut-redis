class ChannelsController < ApplicationController
  
  layout  nil  
  before_filter :authenticate_user!
  
#------------------------------------------------------------------------------------------
 
  def create
    receiver_id = params[:receiver_id]
    #-- Creating Two Channels From receiver side and sender side.
    @channel    = Channel.find_or_create_by_receiver_id_and_sender_id(:receiver_id => receiver_id, :sender_id => current_user.id) #Current user is sender
    Channel.find_or_create_by_receiver_id_and_sender_id(:receiver_id => current_user.id, :sender_id => receiver_id)               #Current user is receiver
    render :text =>  @channel.channel_id
  end
 
#------------------------------------------------------------------------------------------

  def show  
    @current_channel   = Channel.find_by_channel_id(params['id'])
    @receiver_channel =  Channel.find_by_receiver_id_and_sender_id(current_user.id, @current_channel.receiver_id)
    return redirect_to root_path, :flash => {:error => 'Invalid url'} unless @current_channel
  end
  
end
