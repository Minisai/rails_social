class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end

  def friends
    @title = "Friends"
    @user = current_user
  end

end
