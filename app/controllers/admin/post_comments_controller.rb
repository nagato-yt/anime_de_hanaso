class Admin::PostCommentsController < ApplicationController
    
    def destroy
        PostComment.find(params[:post_id]).destroy
        redirect_to request.referer
    end
end
