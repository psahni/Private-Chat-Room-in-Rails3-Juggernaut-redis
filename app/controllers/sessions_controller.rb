class SessionsController < Devise::SessionsController
  
  
  def new
    super
  end
  
  def destroy
    current_user.update_attribute(:current_sign_in_ip, nil)
    super
  end
  
#-------------------private-----------------------------
#   def after_sign_out_path_for(resource)
#    if resource == :user || resource.is_a?(User)
#      debugger
#      super
#    end
#  end
end
