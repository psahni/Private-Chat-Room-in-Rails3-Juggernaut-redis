class HomeController < ApplicationController
  
  before_filter :authenticate_user!


  def index
    @logged_in_users = User.where("'last_time_activity' >= ? AND id <> ?",  Time.now.utc - 10.minutes, current_user.id) 
  end

end
