class Admin::CellsController < Admin::BaseController
  include Admin::Sortable

  before_action :find_project
  before_action :find_cell, only: [:edit, :update]

  def index
    @cells = policy_scope(@project.cells).order("position ASC")

    authorize @cells
  end

  def edit
    authorize @cell
  end

  def update
    authorize @cell

    if @cell.update_attributes cell_params
      redirect_to [:admin, @project, :cells]
    else
      render 'edit'
    end
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_cell
    @cell = @project.cells.find(params[:id])
  end

  def cell_params
    params.require(:cell).permit(:project_id, :icon, :title, :content, :active, :position)
  end
end
