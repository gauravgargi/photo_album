# encoding: utf-8
require 'digest/md5'

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    # "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    "uploads/#{mounted_as}/#{hashed_path( model.class.to_s.underscore + "/" + model.id.to_s )}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  
    # "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :medium_crop_view do
    process :resize_to_fill => [280, 360]
    # 280x360 works for both landscape(cropped - resize_to_fill) and portrait 
  end  
  version :thumb do
    process :resize_to_fit => [112, 144]
  end  

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png tiff nef raw)
  end

  def hashed_path( string )
    Digest::MD5.hexdigest( string )[0,5].split('').join('/')+'/'+string.split('/').last
  end
  
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
