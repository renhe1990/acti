class PollsController < BaseController
  include ActsAsSurvey
  before_action :find_course

  before_action :find_and_authorize_poll, only: [:show, :edit, :update, :destroy]
  before_action :find_question_type_options, only: [:new, :create, :edit, :update, :copy]

  def index
    @polls = policy_scope(collection).by_name(params[:poll_name].presence).page(params[:page])
  end

  def new
    @poll = collection.new

    authorize @poll
  end

  def create
    @poll = collection.new(poll_params)
    authorize @poll

    if @poll.save
      redirect_to [@course, @poll], notice: '问卷创建成功.'
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xls do
        filename = CGI::escape("问卷-#{@poll.name}.xls")
        send_data @poll.to_xls, filename: filename
      end
    end
  end

  def update
    if @poll.update_attributes poll_params
      redirect_to [@course, @poll], notice: '问卷更新成功.'
    else
      render :edit
    end
  end

  def destroy
    @poll.destroy
    redirect_to @course, notice: '问卷删除成功'
  end

  private
  def find_and_authorize_poll
    @poll ||= collection.includes(:questions => :options).find(params[:id])

    authorize @poll
  end

  def find_question_type_options
    @question_type_options = Poll.question_type_options
  end

  def poll_params
    params.require(:poll).permit(:name, :description, :course_id, questions_attributes: [:type, :_destroy, :id, :title, :description, :position, :maximum, :order, :mandatory, options_attributes: [:_destroy, :id, :text, :position]])
  end

  def find_course
    if params[:course_id].present?
      @course = Course.find(params[:course_id])
    elsif params[:public_course_id].present?
      @course = Course.find(params[:public_course_id])
    end
  end

  def collection
    @polls ||= @course.polls
  end
end
