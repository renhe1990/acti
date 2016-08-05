require 'rqrcode/export/png'

class QrcodesController < BaseController
  skip_after_action :verify_authorized
  skip_before_action :teacher_required

  def show
    @url = params[:url]
    respond_to do |format|
      format.png { render qrcode: @url }
    end
  end

  def download
    content = RQRCode::QRCode.new(params[:url]).as_png
    filename = (params[:filename].presence || Time.now.to_s) + ".png"
    send_data content, filename: filename
  end
end
