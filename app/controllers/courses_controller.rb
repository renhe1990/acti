class CoursesController < BaseController
  before_action :find_and_authorize_course, only: [:edit, :update, :show, :destroy]

  def index
    @state = params[:state].presence
    @courses = policy_scope(current_user.courses).by_name(params[:course_name].presence).order("id DESC").page(params[:page])
    if @state
      @courses = @courses.send(@state)
    end

    authorize @courses
  end

  def new
    @course = current_user.courses.new
    authorize @course
  end

  def create
    @course = current_user.courses.new(course_params)
    authorize @course

    if @course.save
      redirect_to @course, notice: '课程创建成功'
    else
      render 'new'
    end
  end

  def show
    @course = current_user.courses.includes([:polls, :questionnaires]).find(params[:id])
    authorize @course
  end

  def edit
  end

  def update
    if @course.update_attributes(course_params)
      redirect_to @course, notice: '课程更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @course.destroy
    redirect_to :courses, notice: '课程删除成功'
  end

  private
  def find_and_authorize_course
    @course = current_user.courses.find(params[:id])
    authorize @course
  end

  def course_params
    params.require(:course).permit(:name, :description, :starts_at, :ends_at)
  end
end
