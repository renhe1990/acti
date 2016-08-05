class QuestionnairesController < BaseController
  include ActsAsSurvey
  before_action :find_course

  before_action :find_and_authorize_questionnaire, only: [:show, :edit, :update, :destroy]
  before_action :find_question_type_options, only: [:new, :create, :edit, :update]

  before_action :normalize_questionnaire_data, only: [:create, :update]

  def index
    @questionnaires = policy_scope(@course.questionnaires).by_name(params[:questionnaire_name].presence).page(params[:page])
  end

  def new
    @questionnaire = @course.questionnaires.new
    authorize @questionnaire
  end

  def create
    @questionnaire = @course.questionnaires.new(questionnaire_params.merge(user: current_user))
    authorize @questionnaire

    if @questionnaire.save
      redirect_to [@course, @questionnaire], notice: '试卷创建成功.'
    else
      render :new
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

  def update
    if @questionnaire.update_attributes questionnaire_params
      redirect_to [@course, @questionnaire], notice: '试卷更新成功'
    else
      render :edit
    end
  end

  def destroy
    @questionnaire.destroy
    redirect_to @course, notice: '试卷删除成功'
  end

  private
  def find_and_authorize_questionnaire
    @questionnaire ||= @course.questionnaires.includes(:questions => :options).find(params[:id])

    authorize @questionnaire
  end

  def find_question_type_options
    @question_type_options = Questionnaire.question_type_options
  end

  def questionnaire_params
    params.require(:questionnaire).permit(:name, :description, :course_id, :display_score, questions_attributes: [:type, :_destroy, :id, :title, :description, :position, options_attributes: [:_destroy, :id, :text, :correct, :position]])
  end

  def normalize_questionnaire_data
    normalize_data!(params[:questionnaire][:questions_attributes])
  end

  def normalize_data!(hash)
    hash.values.each do |question_attribute|
      if %w(SingleChoiceQuestion TrueOrFalseQuestion).include? question_attribute['type']
        question_attribute['options_attributes'].values.each do |option_attribute|
          option_attribute['correct'] = false if option_attribute['correct'].nil?
        end if question_attribute['options_attributes']
      end
    end if hash
  end

  def find_course
    if params[:course_id].present?
      @course = Course.find(params[:course_id])
    elsif params[:public_course_id].present?
      @course = Course.find(params[:public_course_id])
    end
  end
end
