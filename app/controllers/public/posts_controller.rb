class Public::PostsController < ApplicationController
  def index
    @post= Post.new    
    @posts= Post.all
  end

  def show
    @post= Post.find(params[:id])
    @post_comment = PostComment.new 
    
  end

 
  
  def create
    @post= Post.new(post_params)
    @post.user_id= current_user.id
    @post.save
    redirect_to request.referer
  end
  
  def hashtag
    @user  = current_user
    @tag   = Hashtag.find_by(hashname: params[:name])
    @posts = @tag.posts.build
    @post  = @tag.posts.page(params[:page])
    @comment = PostComment.new
    @commens = @posts.comments
  end
    
  
  private
  def post_params
    params.require(:post).permit(:title,:body)
  end
end
