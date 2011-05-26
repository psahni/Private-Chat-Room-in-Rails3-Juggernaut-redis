class Message < ActiveRecord::Base
  
  #Associations
  belongs_to    :channel, :include => [:sender, :receiver]
   
  #Validations
  validates_presence_of :body, :channel_id
  
  
end
