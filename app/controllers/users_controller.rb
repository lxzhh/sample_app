
class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,      only: :destroy
  
  def index
    # self.per_page = 10
    @users = User.paginate(:page => params[:page] ,:per_page => 20)
  end
  
  
  def per_page=(p)
    WillPaginate.per_page = p
  end
  
  
  
  def new
    @user = User.new
  end
  
  
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  
  
  def create
     @user = User.new(params[:user])
     if @user.save
       # Handle a successful save.
       sign_in @user
       flash[:success] = "Welcome to the Sample App!"
       redirect_to @user
     else
       render 'new'
     end
  end
  
  
  def edit
  end


  def update
     if @user.update_attributes(params[:user])
       flash[:success] = "Profile updated"
       sign_in @user
       redirect_to @user
     else
       render 'edit'
     end
  end
  
  
  
  def destroy
     User.find(params[:id]).destroy
     flash[:success] = "User destroyed."
     redirect_to users_path
  end
   
   
  def feed
      # This is preliminary. See "Following users" for the full implementation.
      Micropost.from_users_followed_by(self)
  end
    
    
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end
    
    
  def followers
    @title = "followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  
  private

  def correct_user
       @user = User.find(params[:id])
       redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
        redirect_to(root_path) unless current_user.admin?
  end
end
