class Admin::QuestionnairesController < Admin::BaseController
  include ActsAsSurvey

  before_action :find_course
  before_action :find_and_authorize_questionnaire, only: [:show, :edit, :update, :destroy]

  before_action :find_question_type_options, only: [:new, :create, :edit, :update, :copy]
  before_action :normalize_questionnaire_data, only: [:create, :update]

  def index
    @questionnaires = policy_scope(@course.questionnaires).page(params[:page])
    authorize @questionnaires
  end

  def new
    @questionnaire = @course.questionnaires.new
    authorize @questionnaire
  end

  def create
    @questionnaire = @course.questionnaires.build(questionnaire_params)
    authorize @questionnaire

    if @questionnaire.save
      flash[:notice] = '试卷创建成功'
      if @course.public
        redirect_to admin_public_course_questionnaire_url(@course, @questionnaire)
      else
        redirect_to [:admin, @course, @questionnaire]
      end
    else
      render 'new'
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xls do
        filename = CGI::escape("试卷-#{@questionnaire.name}.xls")
        send_data @questionnaire.to_xls, filename: filename
      end
    end
  end

  def edit
  end

  def update
    if @questionnaire.update_attributes(questionnaire_params)
      flash[:notice] = '试卷更新成功'
      if @course.public
        redirect_to admin_public_course_questionnaire_url(@course, @questionnaire)
      else
        redirect_to [:admin, @course, @questionnaire]
      end
    else
      render 'edit'
    end
  end

  def destroy
    @questionnaire.destroy
    flash[:notice] = '试卷删除成功'
    if @course.public
      redirect_to admin_public_course_questionnaires_url
    else
      redirect_to [:admin, @course, :questionnaires]
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

  def find_and_authorize_questionnaire
    @questionnaire = @course.questionnaires.includes(:questions => [:options]).find(params[:id])
    authorize @questionnaire
  end

  def questionnaire_params
    @questionnaire_params ||= params.require(:questionnaire).permit(:name, :description, :course_id, :display_score, user_ids: [], questions_attributes: [:type, :_destroy, :id, :title, :description, :position, options_attributes: [:_destroy, :id, :text, :correct, :position]])
  end

  def normalize_questionnaire_data
    normalize_data!(params[:questionnaire][:questions_attributes]) if params[:questionnaire][:questions_attributes].present?
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
    @question_type_options = Questionnaire.question_type_options
  end
end
