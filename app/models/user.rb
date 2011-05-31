class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,:confirmable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  #Associations
  has_many :inbound_channels,  :class_name => 'Channel', 
                               :foreign_key => 'receiver_id'
  
  has_many :outbound_channels, :class_name => 'Channel', 
                               :foreign_key => 'sender_id'

  has_many :received_messages, :through => :inbound_channels, 
                               :source => :messages
                               
  has_many :sent_messages,     :through => :outbound_channels,  
                               :source => :messages
                           
  def channel_name
    email.split('@').first
  end
   
 
  
end
