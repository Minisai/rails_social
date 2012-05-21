class MicropostsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to '/home'#root_path
    else
      @feed_items = []
      render '/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to '/home'
  end

  private

  def authorized_user
    @micropost = current_user.microposts.find(params[:id])
  rescue
    redirect_to '/home'#root_path
  end
end