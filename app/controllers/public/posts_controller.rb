class Public::PostsController < ApplicationController
  
  def index
    @post  = Post.new    
    @posts = Post.all
    
    
    #検索
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
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_posts_path
  end
  
  private
  def post_params
    params.require(:post).permit(:title,:body, tag_ids: [])
  end
end
