class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos
  accepts_nested_attributes_for :photos, :allow_destroy => true
  attr_accessible :name, :photos_attributes
  
  validates_presence_of :name
end
