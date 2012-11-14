class AlbumsController < ApplicationController

	before_filter :authenticate_user!, :except => [ :index ]

	rescue_from ActiveRecord::RecordNotFound, :with => :does_not_exist

	def does_not_exist
		render 'shared/does_not_exist'
	end

	def new
		@album = Album.new
	end

	def create
		@album = Album.new( params[:album] )
		@album.user_id = current_user.id
		if @album.save
			flash[:notice] = I18n.t('flash.album_created')
			redirect_to albums_path
		else
			flash.now[:error] = I18n.t('flash.error_while_creating_album')
			render new_album_path
		end
	end

	def index
		if current_user
			@albums = current_user.albums
		else
			render 'albums/home'
		end
	end

	def show
		@album = Album.find( params[:id] )
		render 'shared/not_authorised' unless @album.viewable_by?(current_user)
	end

	def edit
		@album = Album.find( params[:id] )
		render 'shared/not_authorised' unless @album.viewable_by?(current_user)
	end

	def update
		@album = Album.find( params[:id] )
		if @album.update_attributes( params[:album] )
			redirect_to :action => 'show'
		else
			render edit_album_path
		end
	end


end
