class Admin::PublicCoursesController < Admin::BaseController
  skip_after_action :verify_authorized,  except: :index
  skip_after_action :verify_policy_scoped, only: :index
  before_action :find_public_course, only: [:show, :edit, :update, :destroy]

  def index
    @public_courses = Course.common.page(params[:page])
  end

  def new
    @public_course = Course.common.build
    authorize @public_course
  end

  def create
    @public_course = Course.common.build(public_course_params)
    authorize @public_course

    if @public_course.save
      redirect_to admin_public_course_url(@public_course), notice: '公共课程创建成功'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @public_course.update_attributes public_course_params
      redirect_to admin_public_course_url(@public_course), notice: '公共课程更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @public_course.destroy
    redirect_to admin_public_courses_url, notice: '公共课程删除成功'
  end

  private
  def find_public_course
    @public_course = Course.common.find(params[:id])
  end

  def public_course_params
    params.require(:course).permit(:name, :description, :starts_at, :ends_at, :location, :genre, :hour).merge(public: true)
  end
end
