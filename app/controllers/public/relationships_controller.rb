class Public::RelationshipsController < ApplicationController
    before_action :guest_signed_in?, except: [:show,:index]
    def follow
        @user=User.find(params[:user_id])
        user= User.find(params[:user_id])
        current_user.follow(user)
        # redirect_to request.referer
        # render 'public/relationships/follow_btn'
    end
    
    def unfollow
        @user = User.find(params[:user_id])
        user= User.find(params[:user_id])
        current_user.unfollow(user)
        # render 'public/relationships/follow_btn'
        # redirect_to request.referer
    end
    
    def followings
        @user = User.find(params[:user_id])
        user= User.find(params[:user_id])
        @users = user.followings
        # render 'public/relationships/follow_btn'
    end
    
    def followers
        @user = User.find(params[:user_id])
        user= User.find(params[:user_id])
        @users = user.followers
        # render 'public/relationships/follow_btn'
    end
end
