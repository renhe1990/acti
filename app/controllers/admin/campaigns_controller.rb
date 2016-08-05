class Admin::CampaignsController < Admin::BaseController
  include Admin::Sortable

  before_action :find_project
  before_action :find_and_authorize_campaign, only: [:show, :edit, :update, :destroy]

  def index
    @campaigns = policy_scope(@project.campaigns).page(params[:page])
    authorize @campaigns
  end

  def new
    @campaign = @project.campaigns.new
    authorize @campaign
  end

  def create
    @campaign = @project.campaigns.build(campaign_params)
    authorize @campaign

    if @campaign.save
      redirect_to [:admin, @project, @campaign], notice: '模块创建成功'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @campaign.update_attributes(campaign_params)
      redirect_to [:admin, @project, @campaign], notice: '模块更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @campaign.destroy
    redirect_to [:admin, @project, :campaigns]
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_and_authorize_campaign
    @campaign = @project.campaigns.find(params[:id])
    authorize @campaign
  end

  def campaign_params
    params.require(:campaign).permit(:name, :location, :starts_at, :ends_at, :description, :project_id)
  end
end
