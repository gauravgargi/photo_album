class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos, :allow_destroy => true
  attr_accessible :name, :photos_attributes
  
  validates_presence_of :name

  # Checks whether the album belongs to the current signed in user or not
	# Method call - albums_controller.rb/show
  # Returns
  # True or False
  def viewable_by?( user )
  	user.id == self.user_id
  end

end
