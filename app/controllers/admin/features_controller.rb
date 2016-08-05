class Admin::FeaturesController < Admin::BaseController
  include Admin::Sortable
  before_action :find_project
  before_action :find_scope
  before_action :find_and_authorize_feature, only: [:show, :edit, :update, :destroy]

  def index
    @features = policy_scope(@scope).order("position asc")
    authorize @features
  end

  def new
    @feature = @scope.new
    authorize @feature
  end

  def create
    @feature = @scope.build(feature_params)
    authorize @feature

    if @feature.save
      redirect_to [:admin, @project, @feature], notice: '花絮创建成功'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @feature.update_attributes(feature_params)
      redirect_to [:admin, @project, @feature], notice: '花絮更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @feature.destroy
    redirect_to [:admin, @project, :features], notice: '花絮删除成功'
  end

  private
  def find_project
    @project = Project.find_by(id: params[:project_id])
  end

  def find_scope
    @scope = @project ? @project.features : Feature.global
  end

  def find_and_authorize_feature
    @feature = @scope.find(params[:id])
    authorize @feature
  end

  def feature_params
    params.require(:feature).permit(:project_id, :title, :video, :video_screenshot, :cover, :columns, :remove_video, :remove_video_screenshot, :remove_cover, photos_attributes: [:image, :column, :id, :_destroy])
  end
end
