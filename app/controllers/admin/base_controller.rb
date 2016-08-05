class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :admin_required

  protected
  def admin_required
    if current_user.teacher?
      redirect_to :root
    end
  end
end
