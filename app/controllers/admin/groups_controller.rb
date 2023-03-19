class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @groups = Group.all
   
  end

  def show
    @group  = Group.find(params[:id])
  end

  def destroy
    @group  = Group.find(params[:id])
     if @group.destroy
       redirect_to admin_groups_path
     end
  end
end
