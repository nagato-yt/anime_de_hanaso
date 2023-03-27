class Public::UsersController < ApplicationController
   before_action :guest_signed_in?, except: [:show,:index]
   before_action :set_user, only: [:show, :edit, :update, :favorites]
   before_action :is_matching_login_user, only: [:edit, :update]
   
  def show
  end 

  def edit
  end
  
  def update
    if @user.update(user_params)
     flash[:notice]= "ユーザー情報を変更しました！"
     redirect_to public_user_path(@user)
    else
      flash[:notice]= "空欄では保存できません"
     render 'edit'
    end
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
    @user= User.find(params[:user_id])
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
    
    def is_matching_login_user
      user = User.find(params[:id])
     unless user.id == current_user.id
      redirect_to root_path
     end
    end
  
end

