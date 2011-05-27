class SessionsController < Devise::SessionsController
  
  
  def new
    super
  end
  
  def destroy    
    super
  end
  
#-------------------private-----------------------------
#private
#   def after_sign_out_path_for(resource)
#    if resource == :user || resource.is_a?(User)
#      super
#    end
#  end
  
end
