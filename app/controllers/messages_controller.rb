class MessagesController < ApplicationController
  
  def index
    @messages = Message.last
  end
  
  def create
    @message = Message.new(message_params)
    @message.save
    redirect_to messages_path
  end
  
  
  private
  
  def message_params
    params.require(:message).permit(:title, :text)
  end
end
