class Weixin::OpinionnairesController < Weixin::BaseController
  before_action :weixin_signed_in_required
  before_action :weixin_binded_required

  before_action :lecturer_required, only: [:index]

  def show
    @opinionnaire = Opinionnaire.includes(:questions).find(params[:id])
    @total_weight = @opinionnaire.questions.sum(:weight)
  end
end
