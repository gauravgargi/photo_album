class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    	t.string :album_id
    	t.string :image
      t.timestamps
    end
    add_index :photos, :album_id
  end
end
