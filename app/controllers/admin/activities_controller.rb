class Admin::ActivitiesController < Admin::BaseController
  before_action :find_schedule
  before_action :find_and_authorize_activity, only: [:show, :edit, :update, :destroy]
  before_action :find_users, only: [:new, :create, :edit, :update]

  def index
    @activities = policy_scope(@schedule.activities).order("starts_at ASC").page(params[:page])
    authorize @activities
  end

  def new
    @activity = @schedule.activities.new
    authorize @activity
  end

  def create
    @activity = @schedule.activities.build(activity_params)
    authorize @activity

    if @activity.save
      redirect_to [:admin, @schedule, @activity], notice: '活动创建成功'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @activity.update_attributes(activity_params)
      redirect_to [:admin, @schedule, @activity], notice: '活动更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @activity.destroy
    redirect_to [:admin, @schedule, :activities], notice: '活动删除成功'
  end


  private
  def find_users
    @users = @schedule.campaign.project.users.select('users.name, users.id')
  end

  def find_schedule
    @schedule = Schedule.find(params[:schedule_id])
  end

  def find_and_authorize_activity
    @activity = @schedule.activities.find(params[:id])
    authorize @activity
  end

  def activity_params
    params.require(:activity).permit(:schedule_id, :name, :starts_at, :ends_at, :location, user_ids: [])
  end
end
