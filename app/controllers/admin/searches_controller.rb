class Admin::SearchesController < Admin::BaseController
  skip_after_action :verify_policy_scoped

  def index
    @type = params[:type].presence
    if @type
      @searches = @type.classify.constantize.admin_search(params[:keyword]).page(params[:page])
    else
      redirect_to :back
    end
  end
end
