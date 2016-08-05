class Weixin::LuckyDrawResultsController < Weixin::BaseController
  before_action :find_lucky_draw

  include Weixin::InteractiveableController

  def index
    @draw_results = @lucky_draw.draw_results
  end

  def new
    @draw_result = @lucky_draw.draw_results.new
  end

  def create
    @draw_result = @lucky_draw.draw_results.build(user: current_user)
    if @draw_result.save
      redirect_to weixin_lucky_draw_lucky_draw_result_url(@lucky_draw, @draw_result)
    else
      render 'new'
    end
  end

  def show
    @draw_result = @lucky_draw.draw_results.find(params[:id])
  end

  private
  def find_lucky_draw
    @lucky_draw = LuckyDraw.includes(:draw_items).find(params[:lucky_draw_id])
  end

  def participation_required
    unless admin_allowed? || @lucky_draw.users.include?(current_user)
      redirect_to_participation_required_url
    end
  end

  def not_participated_required
    draw_result = DrawResult.where(user: current_user, draw: @lucky_draw).first
    if draw_result
      redirect_to weixin_lucky_draw_lucky_draw_result_url(@lucky_draw, draw_result)
    end
  end
end
