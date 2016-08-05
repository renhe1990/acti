class Weixin::DebateDrawResultsController < Weixin::BaseController
  before_action :find_debate_draw

  include Weixin::InteractiveableController

  def index
    @draw_results = @debate_draw.draw_results.where.not(draw_item: nil)
  end

  def new
    @debate_draw = DebateDraw.includes(:draw_items).find(params[:debate_draw_id])
    @draw_result = @debate_draw.draw_results.new
  end

  def create
    @draw_result = @debate_draw.draw_results.build(user: current_user)
    if @draw_result.save
      redirect_to weixin_debate_draw_debate_draw_result_url(@debate_draw, @draw_result)
    else
      render 'new'
    end
  end

  def show
    @draw_result = @debate_draw.draw_results.find(params[:id])
  end

  private
  def find_debate_draw
    @debate_draw = DebateDraw.includes(:draw_items).find(params[:debate_draw_id])
  end

  def participation_required
    unless admin_allowed? || @debate_draw.users.include?(current_user)
      redirect_to_participation_required_url
    end
  end

  def not_participated_required
    draw_result = DrawResult.where(user: current_user, draw: @debate_draw).first
    if draw_result
      redirect_to weixin_debate_draw_debate_draw_result_url(@debate_draw, draw_result)
    end
  end
end
