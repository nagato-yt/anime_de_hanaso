class Public::PostsController < ApplicationController
  before_action :guest_signed_in?, except: [:show,:index]
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
   if @post.save
     flash[:notice]= "投稿しました！"
      redirect_to request.referer
   else
     flash[:notice]= "空欄では投稿できません！"
     redirect_to request.referer
   end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
     flash[:notice]= "投稿を削除しました！"
    redirect_to public_posts_path
  end
  
  private
  def post_params
    params.require(:post).permit(:title,:body, tag_ids: [])
  end
end
