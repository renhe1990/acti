class Weixin::ProjectsController < Weixin::BaseController
  before_action :find_project, only: [:show]
  before_action :weixin_signed_in_required, only: [:index]
  before_action :weixin_binded_required, only: [:index]

  def index
    if current_user.admin?
      @projects = Project.active
    elsif current_user.teacher?
      @projects = current_user.joined_projects.active
    else
      @projects = current_user.participated_projects.active
    end
  end

  def show
    @cells = @project.cells.active.order("position ASC")
    @banners = @project.banners.order("position ASC")
    @template = params[:template].presence || @project.template

    if @template
      render @template
    else
      render 'show'
    end
  end

  private
  def find_project
    @project = Project.find(params[:id])
  end
end
