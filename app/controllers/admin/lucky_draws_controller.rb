class Admin::LuckyDrawsController < Admin::BaseController
  include ActsAsSurvey

  before_action :find_course
  before_action :find_and_authorize_lucky_draw, only: [:show, :edit, :update, :destroy]

  def index
    @lucky_draws = policy_scope(@course.lucky_draws).page(params[:page])
    authorize @lucky_draws
  end

  def new
    @lucky_draw = @course.lucky_draws.new
    authorize @lucky_draw
  end

  def create
    @lucky_draw = @course.lucky_draws.build(lucky_draw_params)
    authorize @lucky_draw

    if @lucky_draw.save
      redirect_to [:admin, @course, @lucky_draw], notice: '抽奖创建成功'
    else
      render 'new'
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xls do
        filename= CGI::escape("抽奖-#{@lucky_draw.title}.xls")
        send_data @lucky_draw.to_xls, filename: filename
      end
    end
  end

  def edit
  end

  def update
    if @lucky_draw.update_attributes(lucky_draw_params)
      redirect_to [:admin, @course, @lucky_draw], notice: '抽奖更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @lucky_draw.destroy
    redirect_to [:admin, @course, :lucky_draws], notice: '抽奖删除成功'
  end

  private
  def find_course
    @course = Course.find(params[:course_id])
  end

  def find_and_authorize_lucky_draw
    @lucky_draw = @course.lucky_draws.find(params[:id])
    authorize @lucky_draw
  end

  def lucky_draw_params
    @lucky_draw_params ||= params.require(:lucky_draw).permit(:title, :description, :course_id, user_ids: [], draw_items_attributes: [:_destroy, :id, :title, :description, :quantity])
  end
end
