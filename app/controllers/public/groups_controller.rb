class Public::GroupsController < ApplicationController
  
  before_action :ensure_correct_user, only: [:edit, :update]
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
          redirect_to public_groups_path
        else
          render 'new'
        end
    end
    
    def update
      if @group.update(group_params)
        redirect_to public_group_path(@group)
      else
        render "edit"
      end
    end
    
    def join
      @group = Group.find(params[:group_id])
      @group.users << current_user
      redirect_to request.referer
    end
    
    def destroy
      @group = Group.find(params[:id])
      @group.users.delete(current_user)
      redirect_to public_groups_path
    end
    
    def all_destroy
      @group = Group.find(params[:group_id])
      if @group.destroy
        redirect_to public_groups_path
      end
    end
    
    
  private
    def group_params
       params.require(:group).permit(:name, :introduction)
    end
    
    def ensure_correct_user
      @group = Group.find(params[:id])
      unless @group.owner_id == current_user.id
        redirect_to public_groups_path
      end
    end
end
