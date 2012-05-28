class PhotosController < ApplicationController

  def create
    #user = current_user unless user = User.find_by_id(params[:photo][:user_id])
    #album  = user.albums.find_by_id(params[:photo][:album_id])
    #@photo = album.photos.build(:album_id=>params[:photo][:album_id], :name =>params[:photo][:name], :image => params[:photo][:image] )
    #if @photo.save
    #  flash[:success] = "Photo created!"
    #  redirect_to :back
    #else
    #  flash[:success] = "Error: photo don't created"
    #  redirect_to  :back
    #end
  end

  def destroy
    #user = User.find_by_id(params[:user_id])
    #album  = user.albums.find_by_id(params[:album_id])
    #photo = album.photos.find_by_id(params[:id])
    #photo.destroy
    #redirect_to :back
  end

  def index
    @user = current_user unless @user = User.find_by_id(params[:user_id])
    @videos = @user.videos
    @video = Video.new
    #@user = current_user unless @user = User.find_by_id(params[:user_id])
    #@album = Album.new
    #@albums = @user.albums
  end

  def show

    #@user = current_user unless @user = User.find_by_id(params[:user_id])
    #@album  = @user.albums.find_by_id(params[:id])
    #@photos = @album.photos
    #@photo = Photo.new
  end

end