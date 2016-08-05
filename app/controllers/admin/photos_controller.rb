class Admin::PhotosController < Admin::BaseController
  def create
    @photo = Photo.new(photo_params)
    authorize @photo

    if @photo.save
      render json: [@photo.to_jq_upload].to_json
    else
      render json: {}
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:image)
  end
end
