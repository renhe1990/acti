class TinymceAssetsController < Admin::BaseController
  def create
    @image = Image.create(file: params[:file], alt: params[:alt])
    authorize @image

    render json: {
      image: {
        url: @image.file.url
      }
    }, content_type: "text/html"
  end
end
