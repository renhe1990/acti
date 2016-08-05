class Admin::SchedulesController < Admin::BaseController
  include Admin::Sortable

  before_action :find_campaign
  before_action :find_and_authorize_schedule, only: [:show, :edit, :update, :destroy]

  def index
    @schedules = policy_scope(@campaign.schedules).page(params[:page])
  end

  def new
    @schedule = @campaign.schedules.new
    authorize @schedule
  end

  def create
    @schedule = @campaign.schedules.build(schedule_params)
    authorize @schedule

    if @schedule.save
      redirect_to [:admin, @campaign, @schedule], notice: '日程安排创建成功'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @schedule.update_attributes(schedule_params)
      redirect_to [:admin, @campaign, @schedule], notice: '日程安排更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @schedule.destroy
    redirect_to [:admin, @campaign, :schedules], notice: '日程安排删除成功'
  end

  private
  def find_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def find_and_authorize_schedule
    @schedule = @campaign.schedules.find(params[:id])
    authorize @schedule
  end

  def schedule_params
    params.require(:schedule).permit(:campaign_id, :date, :title, :hint)
  end
end
