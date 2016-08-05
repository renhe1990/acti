class Weixin::FeaturesController < Weixin::BaseController
  before_action :find_project
  before_action :find_scope
  before_action :find_title, only: [:index]

  def index
    @features = @scope.order("position ASC")
  end

  def show
    @feature = @scope.find(params[:id])
  end

  private
  def find_project
    @project = Project.find_by(id: params[:project_id])
  end

  def find_scope
    @scope = @project ? @project.features : Feature.global
  end

  def find_title
    @title = params[:title].presence
  end
end
