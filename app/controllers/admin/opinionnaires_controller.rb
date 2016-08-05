class Admin::OpinionnairesController < Admin::BaseController
  include ActsAsSurvey
  before_action :find_course
  before_action :find_and_authorize_opinionnaire, only: [:show, :edit, :update, :destroy]
  before_action :find_question_type_options, only: [:new, :create, :edit, :update, :copy]
  before_action :find_users, only: [:new, :create, :edit, :update]
  before_action :find_lecturers, only: [:new, :create, :edit, :update]

  def index
    @opinionnaires = policy_scope(@course.opinionnaires).page(params[:page])
  end

  def new
    @opinionnaire = @course.opinionnaires.new
    authorize @opinionnaire
  end

  def create
    @opinionnaire = @course.opinionnaires.build(opinionnaire_params)
    authorize @opinionnaire

    if @opinionnaire.save
      redirect_to [:admin, @course, @opinionnaire], notice: '评分创建成功'
    else
      render 'new'
    end
  end

  def show
    @total_weight = @opinionnaire.questions.sum(:weight)
    respond_to do |format|
      format.html
      format.xls do
        filename= CGI::escape("评分-#{@opinionnaire.name}.xls")
        send_data @opinionnaire.to_xls, filename: filename
      end
    end
  end

  def edit
  end

  def update
    # FIXME: it is not a good way in this way
    @opinionnaire.opinionnaire_reviewees.delete_all
    if @opinionnaire.update_attributes opinionnaire_params
      redirect_to [:admin, @course, @opinionnaire], notice: '评分更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @opinionnaire.destroy
    redirect_to [:admin, @course, :opinionnaires], notice: '评分删除成功'
  end

  private
  def find_course
    @course = Course.find(params[:course_id])
  end

  def find_and_authorize_opinionnaire
    @opinionnaire = @course.opinionnaires.includes(:questions => :answers).find(params[:id])
    authorize @opinionnaire
  end

  def find_question_type_options
    @question_type_options = Opinionnaire.question_type_options
  end

  def opinionnaire_params
    @opinionnaire_params ||= params.require(:opinionnaire).permit(:name, :description, :course_id, :comment, :display_score, :lecturer_weight, :student_weight, reviewee_ids: [], user_ids: [], questions_attributes: [:type, :_destroy, :id, :title, :description, :maximum, :position, :weight, options_attributes: [:_destroy, :id, :text, :correct, :position]])
  end

  def find_users
    role = Role.where(name: '特定学员').first
    @users = role.users#.select('name, id')
  end

  def find_lecturers
    @lecturers = @course.campaign.project.lecturers
  end
end
