class Public::GroupMessagesController < ApplicationController
  before_action :guest_signed_in?, except: [:index]
  def index
    @group = Group.find(params[:group_id])
    @messages = Group.find(params[:group_id]).group_messages
    @message = GroupMessage.new
  end
  
  def create
    @message= GroupMessage.new(message_params)
    if @message.save
     redirect_to request.referer
    else
      render 'index'
    end
  end
  
  
  private
    def message_params
      params.require(:group_message).permit(:message, :group_id).merge(user_id: current_user.id)
    end
end
