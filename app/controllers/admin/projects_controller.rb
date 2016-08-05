class Admin::ProjectsController < Admin::BaseController
  include Admin::Sortable
  before_action :find_and_authorize_project, only: [:show, :edit, :update, :destroy, :copy]
  before_action :find_users, only: [:new, :create, :edit, :update]
  before_action :find_lecturers, only: [:new, :create, :edit, :update]

  def index
    @projects = policy_scope(Project).page(params[:page])
    authorize @projects
  end

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    authorize @project

    if @project.save
      redirect_to [:admin, @project], notice: '项目创建成功'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update_attributes(project_params)
      redirect_to [:admin, @project], notice: '项目更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to [:admin, :projects]
  end

  def copy
    project = @project.copy
    if project
      redirect_to [:admin, project], notice: '项目复制成功'
    else
      redirect_to [:admin, @project], alert: '项目复制失败'
    end
  end

  private
  def find_users
    role = Role.where(name: '特定学员').first
    @users = role.users.select('name, id')
  end

  def find_and_authorize_project
    @project = Project.find(params[:id])
    authorize @project
  end

  def project_params
    params.require(:project).permit(:name, :active, :template, :wechat_background, user_ids: [], lecturer_ids: [])
  end

  def find_lecturers
    @lecturers = User.lecturers
  end
end
