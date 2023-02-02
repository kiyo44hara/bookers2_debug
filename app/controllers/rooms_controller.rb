class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :reject_non_related, only: [:show]

  def create
    @room = Room.create
    @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
    redirect_to request.referer
  end

  def show
    @userEntry = Entry.where(user_id: @user.id)
    @room = Room.find(params[:id])
    if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
    else
      redirect_back(fallback_lacation: root_path)
    end
  end
  
  private
  
  def reject_non_related
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to redirect_back(fallback_lacation: root_path)
    end
  end
end
