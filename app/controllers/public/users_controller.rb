class Public::UsersController < ApplicationController
   before_action :guest_signed_in?, except: [:show,:index]
   before_action :set_user, only: [:show, :edit, :update, :favorites, :withdrawal]
   
  def show
  end 

  def edit
  end
  
  def update
    @user.update(user_params)
    flash[:notice]= "ユーザー情報を変更しました！"
    redirect_to public_user_path(@user)
  end

  def index
    @users = User.all
    @q     = User.ransack(params[:q])
    @q_users = @q.result(distinct: true)
  end
  
  def favorites
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts= Post.find(favorites)
  end
  
  def withdrawal
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private
    
    def user_params
      params.require(:user).permit(:name,:introduction,:profile_image)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
  
end

