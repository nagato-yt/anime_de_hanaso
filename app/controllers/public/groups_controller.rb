class Public::GroupsController < ApplicationController
    before_action :guest_signed_in?, except: [:show,:index]
    before_action :ensure_correct_user, only: [:edit,:update,:all_destroy]
    def index
      @groups = Group.all
      @group  = Group.new
    end
  
    def show
      @group = Group.find(params[:id])
    end
  
    def edit
    end
  
    def new
      @group = Group.new
    end
    
    def create
      @group = Group.new(group_params)
      @group.owner_id = current_user.id
      @group.users << current_user
        if @group.save
          flash[:notice]= "グループを作成しました！"
          redirect_to public_groups_path
        else
          flash[:notice]= "空欄では作成できません！"
          redirect_to request.referer
        end
    end
    
    def update
      if @group.update(group_params)
         flash[:notice]= "グループを編集しました！"
        redirect_to public_group_path(@group)
      else
         flash[:notice]= "空欄で編集はできません！"
        render "edit"
      end
    end
    
    def join
      @group = Group.find(params[:group_id])
      @group.users << current_user
      flash[:notice]= "グループに参加しました！"
      redirect_to request.referer
    end
    
    def destroy
      @group = Group.find(params[:id])
      @group.users.delete(current_user)
      flash[:notice]= "グループから抜けました"
      redirect_to request.referer
    end
    
    def all_destroy
      @group = Group.find(params[:group_id])
      if @group.destroy
        flash[:notice]= "グループを削除しました"
        redirect_to public_groups_path
      end
    end
    
    
  private
  
    def group_params
       params.require(:group).permit(:name, :introduction, :profile_image)
    end
    
    def ensure_correct_user
      @group = Group.find(params[:id])
      unless @group.owner_id == current_user.id
        flash[:notice]= "グループのオーナーで無いのでこの操作はできません。"
        redirect_to public_groups_path
      end
    end
end
