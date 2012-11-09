class AlbumsController < ApplicationController

	def new
		@album = Album.new
	end

	def create
		@album = Album.new( params[:album] )
		if @album.save
			redirect_to root_path
		else
			redirect_to new_album_path
		end
	end

	def index
		@albums = Album.all
	end
end
