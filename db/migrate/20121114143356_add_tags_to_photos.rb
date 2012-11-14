class AddTagsToPhotos < ActiveRecord::Migration
  def up
  	add_column :photos, :tags, :string
  end
end
