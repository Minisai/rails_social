class  AlbumsController < ApplicationController
  def create
    user = current_user
    @album  = user.albums.build(params[:album])
    if @album.save
      flash[:success] = "Album created!"
      redirect_to  :back
    else
      flash[:success] = "Error: album don't created"
      render  :back
    end
  end

  def index
    @user = current_user unless @user = User.find_by_id(params[:id])
    @album = Album.new
    @albums = @user.albums
  end

  def show
    @user = current_user unless @user = User.find_by_id(params[:user_id])
    album  = @user.albums.find_by_id(params[:id])
    @photos = album.photos
    @photo = Photo.new
  end

  def destroy
    user = User.find_by_id(params[:user_id])
    album  = user.albums.find_by_id(params[:id])
    album.destroy
    redirect_to :back
  end

end