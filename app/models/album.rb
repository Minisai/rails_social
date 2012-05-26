class Album < ActiveRecord::Base
  attr_accessible :name, :user_id

  belongs_to :user

  has_many :photos

  #def photos
  #  Photo.where("album_id = ?", id)
  #end
end
