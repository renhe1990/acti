class WelcomeController < BaseController
  skip_after_action :verify_policy_scoped, only: :index

  def index
    @start_date = if params[:start_date].present?
                    Date.parse(params[:start_date].presence)
                  else
                    Date.today
                  end
    @courses = policy_scope(Course).by_month(@start_date).page(params[:page])
  end
end
