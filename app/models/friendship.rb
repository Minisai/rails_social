class Friendship < ActiveRecord::Base
  attr_accessible :friend_id, :status
  belongs_to :user
  belongs_to :friend, :class_name => 'User'
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

