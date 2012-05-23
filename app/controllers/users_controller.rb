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
    @friends_title = @user.name.to_s + "'s Friends"
    @micropost = Micropost.new
    @feed_items = current_user.feed.paginate(:page => params[:page])
  end

  def friends
    @user = current_user unless @user = User.find_by_id(params[:id])
    @title = @user.name.to_s + "'s Friends"
    @friends =  @user.friends.paginate(:page => params[:page])
  end

  def news
    @user = current_user

    @microposts = @user.microposts.class.new

    @user.friends.each do |friend|
      @microposts += friend.microposts.paginate(:page => params[:page])
    end
    @microposts = @microposts.paginate(:page => params[:page])
  end
end
