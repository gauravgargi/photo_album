class PhotosController < ApplicationController
	
	rescue_from ActiveRecord::RecordNotFound, :with => :does_not_exist

	def does_not_exist
		render 'shared/does_not_exist'
	end

	def index
		album = Album.find( params[:album_id] )
		render 'shared/not_authorised' unless album.viewable_by?( current_user )
		@photos = album.photos
		# @photos = Photo.find_by_album_id( params[:album_id] )
	end

	def show
		@photo = Photo.find( params[:id])
		render 'shared/not_authorised' unless @photo.viewable_by?( current_user )
	end
end
