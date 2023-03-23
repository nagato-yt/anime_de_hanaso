class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @posts = Post.all
    
    @q     = Post.ransack(params[:q])
    @q_posts= @q.result(distinct: true)
    
    if params[:tag_ids]
      @posts = []
      params[:tag_ids].each do |key, value|
        @posts += Tag.find_by(name: key).posts if value == "1"
      end
      @posts.uniq!
    end
  end

  def destroy
    @post  = Post.find(params[:id])
  end

  def show
    @post  = Post.find(params[:id])
  end
  
  def search
    @results = @q.result
  end
end
