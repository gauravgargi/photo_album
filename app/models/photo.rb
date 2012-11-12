class Photo < ActiveRecord::Base
  belongs_to :album
  attr_accessible :image, :album_id
  mount_uploader :image, ImageUploader

  delegate :viewable_by?, :to => :album, :prefix => false
end
