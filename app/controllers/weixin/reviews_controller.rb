class Weixin::ReviewsController < Weixin::BaseController
  before_action :weixin_signed_in_required
  before_action :weixin_binded_required

  before_action :find_opinionnaire
  before_action :find_reviewable, only: [:new, :create]
  before_action :find_review, only: [:edit, :update]

  before_action :participation_required, only: [:index, :new, :edit, :create]
  before_action :not_participated_required, only: [:index, :new, :edit, :create]

  before_action :set_index, only: [:new, :edit]

  def index
  end

  def new
    @review = @opinionnaire.reviews.new
    @review.answers.build
  end

  def create
    @review = @opinionnaire.reviews.build(review_params.merge(reviewable: @reviewable, reviewer: current_user))
    if @review.save
      redirect_to [:weixin, @opinionnaire, :reviews]
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @review.update_attributes review_params
      redirect_to [:weixin, @opinionnaire, :reviews]
    else
      render 'edit'
    end
  end

  private
  def find_opinionnaire
    @opinionnaire = Opinionnaire.find(params[:opinionnaire_id])
  end

  def find_reviewable
    @reviewable = params[:reviewable_type].constantize.find(params[:reviewable_id])
  end

  def review_params
    params.require(:review).permit(answers_attributes: [:id, :question_id, :option_id, :text, :rating])
  end

  def find_review
    @review = @opinionnaire.reviews.find(params[:id])
  end

  def redirect_if_reviewed
    review = @reviewable.review_from(current_user, @opinionnaire)
    redirect_to [:edit, :weixin, @opinionnaire, review] if review
  end

  def participation_required
    unless admin_allowed? || @opinionnaire.users.include?(current_user)
      redirect_to_participation_required_url
    end
  end

  def not_participated_required
    attempt = Survey::Attempt.where(participant: current_user, survey: @opinionnaire).first
    if attempt
      redirect_to weixin_opinionnaire_attempt_url(@opinionnaire, attempt)
    end
  end

  def set_index
    @index = (params[:index].presence || 1).to_i
  end
end
