require 'juggernaut'

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :update_last_activity
  
#-------------------------------------------------------------------------------------

  def update_last_activity
    if user_signed_in?
      current_user.update_attribute(:last_time_activity, Time.now)
    end
  end
  
#-------------------------------------------------------------------------------------

private

  def stored_location_for( resource ) 
   super 
  end
  
  def after_sign_in_path_for(resource)
    User.current_user = current_user
    super
  end
  
end
