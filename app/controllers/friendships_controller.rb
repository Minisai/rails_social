class FriendshipsController < ApplicationController
  before_filter :setup_friends
# Send a friend request.
# We'd rather call this "request", but that's not allowed by Rails.
  def create
    Friendship.request(@user, @friend)
    flash[:notice] = "Friend request sent."
    UserMailer.friend_email(@user, @friend).deliver
    redirect_to :back
  end

  def accept
    if @user.requested_friends.include?(@friend)
      Friendship.accept(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.name} accepted!"
    else
      flash[:notice] = "No friendship request from #{@friend.name}."
    end
    redirect_to :back
  end

  def decline
    if @user.requested_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.name} declined"
    else
      flash[:notice] = "No friendship request from #{@friend.name}."
    end
    redirect_to :back
  end

  def cancel
    if @user.pending_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship request canceled."
    else
      flash[:notice] = "No request for friendship with #{@friend.name}"
    end
    redirect_to :back
  end

  def delete
    if @user.friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.name} deleted!"
    else
      flash[:notice] = "You aren't friends with #{@friend.name}"
    end
    redirect_to :back
  end

private
  def setup_friends
    @user = current_user
    @friend = User.find_by_id(params[:id])
  end

end
#
#def create
#    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
#    if @friendship.save
#      flash[:notice] = "Added friend."
#      redirect_to :back
#    else
#      flash[:notice] = "Unable to add friend."
#      redirect_to :back
#    end
#  end
#
#  def destroy
#    @friendship = current_user.friendships.find(params[:id])
#    @friendship.destroy
#    flash[:notice] = "Removed friendship."
#    redirect_to :back
#  end
#
#end
