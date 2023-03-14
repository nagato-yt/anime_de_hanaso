class Admin::GroupsController < ApplicationController
  def index
    @groups = Group.all
   
  end

  def show
    @group  = Group.find(params[:id])
  end

  def destroy
    @group  = Group.find(params[:id])
  end
end