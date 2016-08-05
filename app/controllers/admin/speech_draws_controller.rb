class Admin::SpeechDrawsController < Admin::BaseController
  include ActsAsSurvey

  before_action :find_course
  before_action :find_and_authorize_speech_draw, only: [:show, :edit, :update, :destroy]

  def index
    @speech_draws = policy_scope(@course.speech_draws).page(params[:page])
    authorize @speech_draws
  end

  def new
    @speech_draw = @course.speech_draws.new
    authorize @speech_draw
  end

  def create
    @speech_draw = @course.speech_draws.build(speech_draw_params)
    authorize @speech_draw

    if @speech_draw.save
      redirect_to [:admin, @course, @speech_draw], notice: '演讲抽签创建成功'
    else
      render 'new'
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xls do
        filename = CGI::escape("演讲抽签-#{@speech_draw.title}.xls")
        send_data @speech_draw.to_xls, filename: filename
      end
    end
  end

  def edit
  end

  def update
    if @speech_draw.update_attributes(speech_draw_params)
      redirect_to [:admin, @course, @speech_draw], notice: '演讲抽签更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @speech_draw.destroy
    redirect_to [:admin, @course, :speech_draws], notice: '演讲抽签删除成功'
  end

  private
  def find_course
    @course = Course.find(params[:course_id])
  end

  def find_and_authorize_speech_draw
    @speech_draw = @course.speech_draws.find(params[:id])
    authorize @speech_draw
  end

  def speech_draw_params
    @speech_draw_params ||= params.require(:speech_draw).permit(:title, :description, :course_id, user_ids: [], draw_items_attributes: [:_destroy, :id, :title, :description, :time])
  end
end
