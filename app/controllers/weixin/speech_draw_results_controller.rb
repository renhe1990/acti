class Weixin::SpeechDrawResultsController < Weixin::BaseController
  before_action :find_speech_draw

  include Weixin::InteractiveableController

  def index
    @draw_results = @speech_draw.draw_results.where.not(draw_item: nil)
  end

  def new
    @draw_result = @speech_draw.draw_results.new
  end

  def create
    @draw_result = @speech_draw.draw_results.build(user: current_user)
    if @draw_result.save
      redirect_to weixin_speech_draw_speech_draw_result_url(@speech_draw, @draw_result)
    else
      render 'new'
    end
  end

  def show
    @draw_result = @speech_draw.draw_results.find(params[:id])
  end

  private
  def find_speech_draw
    @speech_draw = SpeechDraw.includes(:draw_items).find(params[:speech_draw_id])
  end

  def participation_required
    unless admin_allowed? || @speech_draw.users.include?(current_user)
      redirect_to_participation_required_url
    end
  end

  def not_participated_required
    draw_result = DrawResult.where(user: current_user, draw: @speech_draw).first
    if draw_result
      redirect_to weixin_speech_draw_speech_draw_result_url(@speech_draw, draw_result)
    end
  end
end
