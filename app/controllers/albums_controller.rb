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
		if params[:album][:photos_attributes].nil?
			flash.now[:error] = I18n.t('flash.select_photo')
			render new_album_path
		elsif @album.save
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
			flash[:notice] = I18n.t('flash.album_updated_successfully')
			redirect_to albums_path
		else
			flash.now[:error] = I18n.t('flash.error_while_updating_album')
			render :action => 'edit'
		end
	end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    flash[:notice] = "Album Deleted Successfully"
    redirect_to albums_path
  end

end
