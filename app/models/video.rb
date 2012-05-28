class Video < ActiveRecord::Base
  attr_accessible :name, :path
  belongs_to :user
  mount_uploader :path, VideoUploader


  validates :name, :path, :presence => true
end
