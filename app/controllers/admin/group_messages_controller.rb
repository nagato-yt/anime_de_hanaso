class Admin::GroupMessagesController < ApplicationController
  before_action :authenticate_admin!
    
  def index
    @group = Group.find(params[:group_id])
    @messages = Group.find(params[:group_id]).group_messages
    @message = GroupMessage.new
    @group_user = @message.user
  end 
  
  def create
    @message= GroupMessage.new(message_params)
    @message.save
    redirect_to request.referer
  end
  
  private
    def message_params
      params.require(:group_message).permit(:message, :group_id).merge(user_id: current_user.id)
    end
end

