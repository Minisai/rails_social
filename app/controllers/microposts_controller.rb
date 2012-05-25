class MicropostsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  def create
    creator = current_user
    user = User.find_by_id(params[:micropost][:user_id])
    #user =  self.user
    @micropost  = user.microposts.build(params[:micropost])#current_user.id)
    @micropost.creator_id = creator.id
    @micropost.user_id = params[:micropost][:user_id]
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to  user_profile_path(:id => params[:micropost][:user_id])
    else
      @feed_items = []
      render  "/about"
    end
  end

  def destroy
    @micropost.destroy
    redirect_to :back
  end

  private

  def authorized_user
    @micropost = params[:user].microposts.find_by_id(params[:id])
  rescue
    redirect_to :about#:back
  end
end