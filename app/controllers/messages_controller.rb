class MessagesController < ApplicationController
  before_action :authenticate_user!, :only => [create]

  def create
    if Entry.where(:user_id => current_user.id, :room_id => params[:message][:room_id]).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
    else
      redirect_back(fallback_lacation: root_path)
    end
  end
end
