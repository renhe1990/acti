class Weixin::CellsController < Weixin::BaseController
  before_action :find_cell, only: [:show]

  def show
  end

  private
  def find_cell
    @cell = Cell.find(params[:id])
  end
end
