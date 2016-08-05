# encoding: utf-8

class VideoUploader < FileUploader
  def extension_white_list
    %w(mp4)
  end
end
