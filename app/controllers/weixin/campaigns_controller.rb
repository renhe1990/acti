class Weixin::CampaignsController < Weixin::BaseController
  before_action :find_project
  before_action :find_title, only: [:index]

  def index
    @campaigns = @project.campaigns.includes(:courses => [:lessons => :schedule])
  end

  def show
    @campaign = @project.campaigns.includes(:schedules => :events).find(params[:id])
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_title
    @title = params[:title].presence
  end
end
