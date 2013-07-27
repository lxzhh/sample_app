class RelationshipsController < ApplicationController
  before_filter :signed_in_user
  
  
  def index
    
  end


  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end

  end
  
  #创建就是关注用户动作
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    
    respond_to do |format|
      format.html { redirect_to @user }
      format.jss
    end
  
end