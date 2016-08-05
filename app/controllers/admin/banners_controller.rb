class Admin::BannersController < Admin::BaseController
  include Admin::Sortable
  before_action :find_project
  before_action :find_scope
  before_action :find_banner, only: [:edit, :update, :destroy]

  def index
    @banners = policy_scope(@scope).order("position ASC")

    authorize @banners
  end

  def new
    @banner = @scope.new
    authorize @banner
  end

  def create
    @banner = @scope.build(banner_params)
    authorize @banner

    if @banner.save
      redirect_to [:admin, @project, :banners], notice: 'Banner创建成功'
    else
      render 'new'
    end
  end

  def edit
    authorize @banner
  end

  def update
    authorize @banner
    if @banner.update_attributes banner_params
      redirect_to [:admin, @project, :banners], notice: 'Banner更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    authorize @banner

    @banner.destroy
    redirect_to [:admin, @project, :banners], notice: 'Banner删除成功'
  end

  def sort
    authorize Banner

    params[:banners].each_with_index do |id, index|
      Banner.update(id, position: index + 1)
    end
    render nothing: true
  end

  private
  def find_project
    @project = Project.find_by(id: params[:project_id])
  end

  def find_scope
    @scope = @project ? @project.banners : Banner.global
  end

  def find_banner
    @banner = @scope.find(params[:id])
  end

  def banner_params
    if params[:banner].present?
      params.require(:banner).permit(:project_id, :image, :position)
    else
      {}
    end
  end
end
