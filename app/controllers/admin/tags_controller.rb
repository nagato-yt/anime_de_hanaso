class Admin::TagsController < ApplicationController
    
    def create
        @tag = Tag.new(tag_params)
        @tag.save
        redirect_to request.referer
    end
    
    def index
        @tag = Tag.new
        @tags = Tag.all
    end
    
    def edit
        @tag = Tag.find(params[:id])
    end
    
    def update
        @tag = Tag.find(params[:id])
     if @tag.update(tag_params)
        redirect_to admin_tags_path
     else
        redirect_to edit_admin_tag_path(@tag)
     end
    end
    
private
    def tag_params
         params.require(:tag).permit(:name)
    end
    
     
end