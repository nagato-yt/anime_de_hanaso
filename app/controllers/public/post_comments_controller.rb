class Public::PostCommentsController < ApplicationController
  before_action :guest_signed_in?
  def create
    post= Post.find(params[:post_id])
    @comment= current_user.post_comments.new(post_comment_params)
    @comment.post_id= post.id
    @comment.save
    # render 'public/posts/show'
    # redirect_to public_post_path(post)
     @post_comment = PostComment.new 
  end

  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy
    # redirect_to request.referer
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
    
  end 
end
