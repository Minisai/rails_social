class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = current_user unless @user = User.find(params[:id])
    @title = @user.name
    @friends_title = "Friends"
    @micropost = Micropost.new
    @feed_items = @user.feed.paginate(:page => params[:page])
  end

  def friends
    @user = current_user unless @user = User.find_by_id(params[:id])
    @title = @user.name.to_s + "'s Friends"

    @friends =  @user.friends.paginate(:page => params[:page])
  end


  def news
    @user = current_user

    @feed_items = @user.microposts.class.new
    @user.friends.each do |friend|
      @feed_items += friend.news_feed
    end
    @feed_items = @feed_items.paginate(:page => params[:page])
  end

  def change_status
    @user = current_user
    @user_status = @user.user_status
    respond_to do |format|
      format.js
    end
  end

  def update_status
    current_user.status = params[:new_status]
  end
end
