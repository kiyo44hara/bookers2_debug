class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    
    following = current_user.relationships.build(followed_id:params[:user_id])
    following.save
    redirect_to request.referrer
  end
  
  def destroy
    following = current_user.relationships.fing_by(followed_id:params[:user_id])
  　following.destroy
  　redirect_to request.referrer
  end
  
  private
  # フォロー一覧ページとフォロワー一覧ページ用のコントローラを記述
  
end
