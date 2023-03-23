class Admin::UsersController < ApplicationController
   before_action :authenticate_admin!
  def index
    @users= User.all
    
    @q     = User.ransack(params[:q])
    @q_users = @q.result(distinct: true)
  end

  def destroy
     @user = User.find(params[:id])
  end

  def show
     @user = User.find(params[:id])
  end
  
  def withdrawal
    @user = User.find(params[:id])
    if @user.is_deleted == true
       redirect_to admin_user_path(@user)
    else
      @user.update(is_deleted: true)
      reset_session
      flash[:notice] = "退会処理を実行いたしました"
      redirect_to admin_users_path
    end
  end
  
end
