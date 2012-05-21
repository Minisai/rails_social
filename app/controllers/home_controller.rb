class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    @title = "Home"
    @micropost = Micropost.new
    @feed_items = current_user.feed.paginate(:page => params[:page])
  end
end
