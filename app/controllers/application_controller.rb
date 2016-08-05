class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Pundit

  after_action :verify_authorized,  except: :index
  after_action :verify_policy_scoped, only: :index
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper_method :current_user
  helper_method :user_signed_in?

  before_action :signed_in_required

  protected
  def current_user
    @current_user ||= User.with_deleted.find(session[:user_id]) rescue nil
  end

  def user_signed_in?
    !!current_user
  end

  def user_binded?
    current_user.uid.present?
  end

  def signed_in_required
    if current_user
      redirect_to sign_in_url, alert: '该账号已被冻结!' if current_user.deleted?
    else
      redirect_to sign_in_url, alert: '该账号没有登录，请登录以后继续使用'
    end
  end

  def user_not_authorized
    flash[:error] = "你没有权限进行此操作"
    redirect_to(request.referrer || root_path)
  end
end
