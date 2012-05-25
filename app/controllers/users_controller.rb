class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
    @friendships = current_user.friendships
    @friends = current_user.friends
  end

  def show
    @user = current_user unless @user = User.find(params[:id])
    #@microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
    @friends_title = "Friends"
    @micropost = Micropost.new
    @feed_items = @user.feed.paginate(:page => params[:page])
    @friendships = current_user.friendships
    @inverse_friendships = current_user.inverse_friendships

    @followers = @user.friends.class.new
    not_friends = @user.friendships.where("user_id != ?", params[:id])
    inverse_friends = @user.inverse_friendships.where("friend_id = ?", params[:id])
    @followerships = not_friends & inverse_friends
    #@followers = followerships.friends
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
end
