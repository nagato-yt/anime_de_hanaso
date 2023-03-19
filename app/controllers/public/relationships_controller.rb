class Public::RelationshipsController < ApplicationController
    
    def create 
        user= User.find(params[:user_id])
        current_user.follow(user)
        redirect_to request.referer
        # render 'public/relationships/follow_btn'
    end
    
    def destroy
        user= User.find(params[:user_id])
        current_user.unfollow(user)
        # render 'public/relationships/follow_btn'
        redirect_to request.referer
    end
    
    def followings
        user= User.find(params[:user_id])
        @users = user.followings
        # render 'public/relationships/follow_btn'
    end
    
    def followers
        user= User.find(params[:user_id])
        @users = user.followers
        # render 'public/relationships/follow_btn'
    end
end
