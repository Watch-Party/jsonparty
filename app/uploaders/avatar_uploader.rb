

class AvatarUploader < CarrierWave::Uploader::Base

  #allows carrierwave to resize images
  include CarrierWave::MiniMagick

  #default image for user avatars
  def default_url(*args)
    "https://s3.amazonaws.com/watch-party/uploads/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  #storage type for this uploader
  storage :fog

  #only accept image files
  def content_type_whitelist
    /image\//
  end

  #resize all incoming images to standard size
  process resize_to_fit: [500, 500]

  #creates a thumbnail version of avatar image
  version :thumb do
    process resize_to_fill: [35, 35]
  end

  #storage directory
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
