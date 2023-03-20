class Admin::PostCommentsController < ApplicationController
    before_action :authenticate_admin!
    
    def destroy
        PostComment.find(params[:post_id]).destroy
        redirect_to request.referer
    end
end
