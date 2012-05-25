# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer         default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  authentication_token   :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  name                   :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable, :lockable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :confirmed_at

  has_many :microposts, :dependent => :destroy

  has_many :friendships

  has_many :friends,
           :through => :friendships,
           :conditions => "status = 'accepted'",
           :order => :name


  has_many :requested_friends,
           :through => :friendships,
           :source => :friend,
           :conditions => "status = 'requested'",
           :order => :created_at


  has_many :pending_friends,
           :through => :friendships,
           :source => :friend,
           :conditions => "status = 'pending'",
           :order => :created_at


  def feed
    Micropost.where("user_id = ?", id)
  end

  def news_feed
    Micropost.where("creator_id = ?", id)
  end

  def true_friends
    inverse_friends & friends
    #user_friendships = Friendship.where("user_id = ?", id)
    #user_inverse_friendships = Friendship.where("friend_id = ?", id)
    #true_friendships =  user_friendships & user_inverse_friendships
    #friends = Friend.where("user_id = ?", id)
    #inverse_friends = Inverse_friend.where("friend_id = ?", id)
    #true_friends = friends & inverse_friends
  end

  def folowers
    not_friends = friends.where("user_id != ?", id)
    inverse_friends = Inverse_friend.where("friend_id = ?", id)
    followers = not_friends & inverse_friends
  end

  def folower_to
    friends = Friend.where("user_id = ?", id)
    inverse_not_friends = Inverse_friend.where("friend_id != ?", id)
    follower_to = friends & inverse_not_friends
  end


end
