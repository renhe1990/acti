class Admin::LessonsController < Admin::BaseController
  before_action :find_schedule
  before_action :find_courses, only: [:new, :create, :edit, :update]
  before_action :find_and_authorize_lesson, only: [:show, :edit, :update, :destroy]

  def index
    @lessons = policy_scope(Lesson).where(schedule_id: @schedule).order("starts_at ASC").page(params[:page])
    authorize @lessons
  end

  def new
    @lesson = @schedule.lessons.new
    authorize @lesson
  end

  def create
    @lesson = @schedule.lessons.build(lesson_params)
    authorize @lesson

    if @lesson.save
      redirect_to [:admin, @schedule, @lesson]
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @lesson.update_attributes(lesson_params)
      redirect_to [:admin, @schedule, @lesson], notice: '课程安排更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @lesson.destroy
    redirect_to [:admin, @schedule, :lessons]
  end

  private
  def find_courses
    @courses = @schedule.campaign.courses
  end

  def find_schedule
    @schedule = Schedule.find(params[:schedule_id])
  end

  def find_and_authorize_lesson
    @lesson = @schedule.lessons.find(params[:id])
    authorize @lesson
  end

  def lesson_params
    params.require(:lesson).permit(:schedule_id, :name, :starts_at, :ends_at, :location, :course_id)
  end
end
