class Public::PostCommentsController < ApplicationController
  
  def create
    post= Post.find(params[:post_id])
    comment= current_user.post_comments.new(post_comment_params)
    comment.post_id= post.id
    comment.save
    redirect_to public_post_path(post)
  end

  def destroy
    PostComment.find(params[:post_id]).destroy
    redirect_to request.referer
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
    
  end 
end
