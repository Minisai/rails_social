class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    @title = "Home"
    @users = User.all
  end
end
