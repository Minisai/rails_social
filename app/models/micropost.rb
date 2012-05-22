class Micropost < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user

  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true

  default_scope :order => 'microposts.created_at DESC'

  #def user
  #  User.where("id = ?", Micropost.where("id = ?", id).user_id)
  #end
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

