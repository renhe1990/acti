class BaseController < ApplicationController
  before_action :teacher_required

  protected
  def teacher_required
    if current_user.admin?
      redirect_to [:admin, :root]
    end
  end
end
