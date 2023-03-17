class Public::UsersController < ApplicationController
  # before_action :ensure_normal_user, only: [:edit]
  def show
    @user= User.find(params[:id])
  end 

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user= User.find(params[:id])
    @user.update(user_params)
    redirect_to public_user_path(@user)
  end

  def index
    @users = User.all
    @q     = User.ransack(params[:q])
    @q_users = @q.result(distinct: true)
  end
  
  def favorites
    @user= User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts= Post.find(favorites)
  end

  private
    def ensure_normal_user
      redirect_to root_path
    end
    
    def user_params
      params.require(:user).permit(:name,:introduction)
    end

end

