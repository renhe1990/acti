# encoding: utf-8

class IconUploader < FileUploader
  include CarrierWave::MiniMagick

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
