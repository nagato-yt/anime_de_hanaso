class Admin::UsersController < ApplicationController
  def index
    @users= User.all
   
  end

  def destroy
     @user = User.find(params[:id])
  end

  def show
     @user = User.find(params[:id])
  end
end
