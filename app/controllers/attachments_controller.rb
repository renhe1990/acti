class AttachmentsController < BaseController
  before_action :set_course
  before_action :find_attachment, only: [:destroy]

  def create
    @attachment = @course.attachments.build(attachment_params)
    authorize @course
    if @attachment.save
      render json: [@attachment.to_jq_upload].to_json
    else
      render json: {}
    end
  end

  def destroy
    authorize @course
    @attachment.destroy
    redirect_to :back
  end

  private
  def attachment_params
    params.require(:attachment).permit(:asset)
  end

  def find_attachment
    @attachment = @course.attachments.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end
end
