class Public::PostsController < ApplicationController
  def index
    @post  = Post.new    
    @posts = Post.all
    
    #検索
    @q     = Post.ransack(params[:q])
    @q_posts= @q.result(distinct: true)
  end

  def show
    @post= Post.find(params[:id])
    @post_comment = PostComment.new 
    
  end

  def edit
  end
  
  def create
    @post= Post.new(post_params)
    @post.user_id= current_user.id
    @post.save
    redirect_to request.referer
  end
  
  private
  def post_params
    params.require(:post).permit(:title,:body)
  end
end
