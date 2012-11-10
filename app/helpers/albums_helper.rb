module AlbumsHelper

	def add_new_photo_fields( f, photo )
		f.simple_fields_for :photos, photo do |p|
			p.file_field :image
	  end
	end

end
