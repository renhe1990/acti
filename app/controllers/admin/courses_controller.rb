class Admin::CoursesController < Admin::BaseController
  include Admin::Sortable
  before_action :find_campaign, except: [:draw_results]
  before_action :find_and_authorize_course, only: [:show, :edit, :update, :destroy]
  before_action :find_lecturers, only: [:new, :create, :edit, :update]

  def index
    @courses = policy_scope(@campaign.courses).order("starts_at ASC").page(params[:page])
    authorize @courses
  end

  def new
    @course = @campaign.courses.new
    authorize @course
  end

  def create
    @course = @campaign.courses.build(course_params)
    authorize @course

    if @course.save
      redirect_to [:admin, @campaign, @course], notice: '课程创建成功'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @course.update_attributes(course_params)
      redirect_to [:admin, @campaign, @course], notice: '课程更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @course.destroy
    redirect_to [:admin, @campaign, :courses]
  end

  def draw_results
    @course = Course.find(params[:id])
    authorize @course

    @draw_results = Draw.find(params[:draw_id]).draw_results.joins(:draw_item).where.not(draw_item_id: nil).order("draw_items.position ASC")

    render json: @draw_results.map{|draw_result| draw_result.user_id.to_s}.uniq
  end

  private
  def find_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def find_and_authorize_course
    @course = @campaign.courses.find(params[:id])
    authorize @course
  end

  def course_params
    params.require(:course).permit(:campaign_id, :name, :description, :starts_at, :ends_at, :location, user_ids: [], lecturer_ids: [])
  end

  def find_lecturers
    @lecturers = @campaign.project.lecturers
  end
end
