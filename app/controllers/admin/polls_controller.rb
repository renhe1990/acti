class Admin::PollsController < Admin::BaseController
  include ActsAsSurvey

  before_action :find_course
  before_action :find_and_authorize_poll, only: [:show, :edit, :update, :destroy]

  before_action :find_question_type_options, only: [:new, :create, :edit, :update, :copy]
  before_action :normalize_poll_data, only: [:create, :update]

  def index
    @polls = policy_scope(Poll).where(course_id: @course).page(params[:page])
    authorize @polls
  end

  def new
    @poll = @course.polls.new
    authorize @poll
  end

  def create
    @poll = @course.polls.build(poll_params)
    authorize @poll

    if @poll.save
      flash[:notice] = '问卷创建成功'
      if @course.public
        redirect_to admin_public_course_poll_url(@course, @poll)
      else
        redirect_to [:admin, @course, @poll]
      end
    else
      render 'new'
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

  def edit
  end

  def update
    if @poll.update_attributes(poll_params)
      flash[:notice] = '问卷更新成功'
      if @course.public
        redirect_to admin_public_course_poll_url(@course, @poll)
      else
        redirect_to [:admin, @course, @poll]
      end
    else
      render 'edit'
    end
  end

  def destroy
    @poll.destroy
    flash[:notice] = '问卷删除成功'
    if @course.public
      redirect_to admin_public_course_polls_url
    else
      redirect_to [:admin, @course, :polls]
    end
  end

  private
  def find_course
    if params[:course_id].present?
      @course = Course.find(params[:course_id])
    elsif params[:public_course_id].present?
      @course = Course.find(params[:public_course_id])
    end
  end

  def find_and_authorize_poll
    @poll = @course.polls.includes(questions: [:answers, :options]).find(params[:id])
    authorize @poll
  end

  def poll_params
    @poll_params ||= params.require(:poll).permit(:name, :description, :course_id, :comment, user_ids: [], questions_attributes: [:type, :_destroy, :id, :title, :description, :position, :mandatory, options_attributes: [:_destroy, :id, :text, :position]])
  end

  def normalize_poll_data
    normalize_data!(params[:poll][:questions_attributes]) if params[:poll][:questions_attributes].present?
  end

  def normalize_data!(hash)
    hash.values.each do |question_attribute|
      if %w(SingleChoiceQuestion TrueOrFalseQuestion).include? question_attribute['type']
        question_attribute['options_attributes'].values.each do |option_attribute|
          option_attribute['correct'] = false if option_attribute['correct'].nil?
        end if question_attribute['options_attributes']
      end
    end
  end

  def find_question_type_options
    @question_type_options = Poll.question_type_options
  end
end
