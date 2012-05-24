class Micropost < ActiveRecord::Base
  attr_accessible :content, :creator_id, :user_id

  belongs_to :user
  belongs_to :creator, :class_name => 'User'

  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true

  default_scope :order => 'microposts.created_at DESC'

  def user
    User.where("id = ?", user_id)
  end
end
# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

