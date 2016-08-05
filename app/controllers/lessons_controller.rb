class LessonsController < BaseController
  before_action :find_and_authorize_lesson, only: [:edit, :update]

  def index
    @state = params[:state].presence
    @lessons = policy_scope(Lesson).by_name(params[:lesson_name].presence).order("id DESC").page(params[:page])
    if @state
      @lessons = @lessons.send(@state)
    end

    authorize @lessons
  end

  def new
    @lesson = current_user.lessons.new
    authorize @lesson
  end

  def create
    @lesson = current_user.lessons.new(lesson_params)
    authorize @lesson

    if @lesson.save
      redirect_to @lesson, notice: '课程创建成功'
    else
      render 'new'
    end
  end

  def show
    @lesson = current_user.lessons.includes(course: [:polls, :questionnaires]).find(params[:id])
    authorize @lesson
  end

  def edit
  end

  def update
    if @lesson.update_attributes(lesson_params)
      redirect_to @lesson, notice: '课程更新成功'
    else
      render 'edit'
    end
  end

  private
  def find_and_authorize_lesson
    @lesson = current_user.lessons.find(params[:id])
    authorize @lesson
  end

  def lesson_params
    params.require(:lesson).permit(:name, :description, :starts_at, :ends_at)
  end
end
