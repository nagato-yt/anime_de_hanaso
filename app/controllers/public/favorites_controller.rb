class Public::FavoritesController < ApplicationController
    before_action :guest_signed_in?, except: [:index]
    def create
        post= Post.find(params[:post_id])
        @favorite = current_user.favorites.new(post_id: post.id)
        @favorite.save
    end
    
    def destroy
        post= Post.find(params[:post_id])
        @favorite = current_user.favorites.find_by(post_id: post.id)
        @favorite.destroy
    end
    
    def index
        @favorites= current_user.favorited.posts
        
    end
end
