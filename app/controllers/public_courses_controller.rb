class PublicCoursesController < BaseController
  skip_after_action :verify_authorized,  except: :index
  skip_after_action :verify_policy_scoped, only: :index

  def index
    @public_courses = Course.common.search('', params.merge(page: params[:page], public: true))
  end

  def show
    @public_course = Course.common.find(params[:id])
  end

  def copy
    @public_course = Course.common.find(params[:id])
    @course = @public_course.copy(user: current_user, public: false, public_course: @public_course)

    if @course.valid?
      redirect_to [:edit, @course], notice: '成功添加到新课程'
    else
      redirect_to public_course_url(@public_course), alert: '无法添加到新课程，请检查后重新添加'
    end
  end
end
