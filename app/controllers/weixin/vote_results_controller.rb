class Weixin::VoteResultsController < Weixin::BaseController
  before_action :find_vote

  include Weixin::InteractiveableController

  def index
    @vote_results = @vote.vote_results
  end

  def new
    @vote_result = @vote.vote_results.new
    @vote_result.vote_result_items.build
  end

  def create
    @vote_result = @vote.vote_results.build(vote_result_params)
    @vote_result.user = current_user

    if @vote_result.save
      redirect_to [:weixin, @vote, @vote_result]
    else
      render 'new'
    end
  end

  def show
  end

  private
  def find_vote
    @vote = Vote.includes(:vote_items => { :vote_item_options => :user }).find(params[:vote_id])
  end

  def vote_result_params
    params.require(:vote_result).permit(vote_result_items_attributes: [:vote_item_option_id])
  end

  def participation_required
    unless admin_allowed? || @vote.users.include?(current_user)
      redirect_to_participation_required_url
    end
  end

  def not_participated_required
    vote_result = @vote.vote_results.where(user: current_user).first
    if vote_result
      redirect_to [:weixin, @vote, vote_result]
    end
  end
end
