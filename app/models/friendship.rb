class Friendship < ActiveRecord::Base
  attr_accessible :friend_id, :user_id, :status
  belongs_to :user
  belongs_to :friend, :class_name => 'User', :foreign_key => "friend_id"
  validates_presence_of :user_id, :friend_id

  # Return true if the users are (possibly pending) friends.
  def self.exists?(user, friend)
    not find_by_user_id_and_friend_id(user, friend).nil?
  end

  # Record a pending friend request.
  def self.request(user, friend)
    unless user == friend or Friendship.exists?(user, friend)
      transaction do
        Friendship.create(:user_id => user.id, :friend_id => friend.id, :status => 'pending')
        Friendship.create(:user_id => friend.id, :friend_id => user.id, :status => 'requested')
      end
    end
  end

  # Accept a friend request.
  def self.accept(user, friend)
    transaction do
      accept_one_side(user, friend)
      accept_one_side(friend, user)
    end
  end

  # Delete a friendship or cancel a pending request.
  def self.breakup(user, friend)
    transaction do
      Friendship.delete(find_by_user_id_and_friend_id(user, friend))
      Friendship.delete(find_by_user_id_and_friend_id(friend, user))
    end
  end

  private
  # Update the db with one side of an accepted friendship request.
  def self.accept_one_side(user, friend)
    request = find_by_user_id_and_friend_id(user, friend)
    request.status = 'accepted'
    request.save!
  end

end
# == Schema Information
#
# Table name: friendships
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  friend_id  :integer
#  type       :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

