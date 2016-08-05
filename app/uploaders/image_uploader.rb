# encoding: utf-8

class ImageUploader < FileUploader
  include CarrierWave::MiniMagick

  version :weixin do
    process :resize_to_limit => [640, nil]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
