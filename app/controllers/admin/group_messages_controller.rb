class Admin::GroupMessagesController < ApplicationController
  before_action :authenticate_admin!
    
  def index
    @group = Group.find(params[:group_id])
    @messages = Group.find(params[:group_id]).group_messages
    @message = GroupMessage.new
  end 
  
  private
  
end

