class HomeController < ApplicationController
  
  before_filter :authenticate_user!


  def index
    @logged_in_users = User.where("current_sign_in_ip IS NOT  NULL AND id <> #{ current_user.id }") 
  end

end
