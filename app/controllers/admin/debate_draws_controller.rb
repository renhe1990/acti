class Admin::DebateDrawsController < Admin::BaseController
  include ActsAsSurvey

  before_action :find_course
  before_action :find_and_authorize_debate_draw, only: [:show, :edit, :update, :destroy]

  def index
    @debate_draws = policy_scope(@course.debate_draws).where(course_id: @course).page(params[:page])
    authorize @debate_draws
  end

  def new
    @debate_draw = @course.debate_draws.new
    @debate_draw.draw_items.build(title: '正方')
    @debate_draw.draw_items.build(title: '反方')
    authorize @debate_draw
  end

  def create
    @debate_draw = @course.debate_draws.build(debate_draw_params)
    authorize @debate_draw

    if @debate_draw.save
      redirect_to [:admin, @course, @debate_draw], notice: '辩论抽签创建成功'
    else
      render 'new'
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xls do
        filename= CGI::escape("辩论抽签-#{@debate_draw.title}.xls")
        send_data @debate_draw.to_xls, filename: filename
      end
    end
  end

  def edit
  end

  def update
    if @debate_draw.update_attributes(debate_draw_params)
      redirect_to [:admin, @course, @debate_draw], notice: '辩论抽签更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @debate_draw.destroy
    redirect_to [:admin, @course, :debate_draws], notice: '辩论抽签删除成功'
  end

  private
  def find_course
    @course = Course.find(params[:course_id])
  end

  def find_and_authorize_debate_draw
    @debate_draw = @course.debate_draws.find(params[:id])
    authorize @debate_draw
  end

  def debate_draw_params
    @debate_draw_params ||= params.require(:debate_draw).permit(:title, :description, :course_id, user_ids: [], draw_items_attributes: [:_destroy, :id, :title, :description, :quantity])
  end
end
