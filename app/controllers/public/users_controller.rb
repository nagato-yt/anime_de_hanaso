class Public::UsersController < ApplicationController
  def show
    @user= User.find(params[:id])
  end 

  def edit
  end

  def index
    @users=User.all
  end
  
  def favorites
    @user= User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts= Post.find(favorites)
  end

end
