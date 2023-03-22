class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
     before_action :authenticate_any!, except: [:top]
  private
  
    def authenticate_any!
      if user_signed_in?
          true
      else
          authenticate_admin!
      end
    end

  
    def after_sign_in_path_for(resource_or_scope)
        if resource_or_scope.is_a?(Admin)
            admin_root_path
        else
            flash[:notice]= "おかえりなさい！"
            root_path 
        end
    end

  
    def after_sign_out_path_for(resource_or_scope)
        if resource_or_scope == :user
            root_path flash[:notice]= "いってらしゃいませ！"
        elsif resource_or_scope == :admin
            admin_root_path flash[:notice]= "いってらしゃいませ！"
        else
            root_path flash[:notice]= "いってらしゃいませ！"
        end
    end
    
    def guest_signed_in?
        if current_user.id == User.guest.id
            redirect_to root_path flash[:notice]= "ゲストユーザーでログインしました！"
        end
    end



  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
