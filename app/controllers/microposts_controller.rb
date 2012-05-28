class MicropostsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  def create
    creator = current_user
    user = User.find_by_id(params[:micropost][:user_id])
    @micropost  = user.microposts.build(params[:micropost])
    @micropost.creator_id = creator.id
    #@micropost.user_id = params[:micropost][:user_id]
    if @micropost.save
      flash[:success] = "Micropost created!"
      respond_to do |format|
        format.html  { redirect_to  user_profile_path(:id => params[:micropost][:user_id])}
        format.js
      end
    else
      @feed_items = []
      redirect_to :back


    end
  end

  def destroy
    @micropost.destroy
    redirect_to :back
  end

  def new
    @micropost = Micropost.new
    @user = User.find_by_id(params[:user_id])
    respond_to do |format|
      format.html  { redirect_to :back }
      format.js
    end
  end

  private

  def authorized_user
    user = User.find_by_id(params[:user_id])
    @micropost = user.microposts.find_by_id(params[:id])
  rescue
    redirect_to :back
  end
end