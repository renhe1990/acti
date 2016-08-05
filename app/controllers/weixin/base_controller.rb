class Weixin::BaseController < ApplicationController
  layout 'weixin'

  skip_before_action :verify_authenticity_token

  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  skip_before_action :signed_in_required

  before_action :store_location

  protected
  def weixin_signed_in_required
    logger.warn "*** BEGIN RAW REQUEST HEADERS ***"
    self.request.env.select { |key, val| key.match("^HTTP.*")}.each do |header|
      logger.info "#{header[0]}: #{header[1]}"
    end
    logger.warn "*** END RAW REQUEST HEADERS ***"

    unless anonymous_allowed?
      if current_user
        redirect_to new_weixin_session_url, alert: '该用户已被冻结!' if current_user.deleted?
      else
        redirect_to new_weixin_session_url, alert: '该账号没有登录，请登录以后继续使用'
      end
    end
  end

  def weixin_binded_required
    unless anonymous_allowed? || user_binded?
      redirect_to weixin_static_url(:info), alert: "该账号没有绑定微信，请绑定以后继续使用。#{ view_context.link_to '立即绑定', '/auth/wechat' }"
    end
  end

  def store_location
    if request.get? && !["/weixin/sessions/new", "/weixin/statics/info", "/weixin/bindings/new", "/auth/failure", "/auth/wechat/callback"].include?(request.path)
      session[:user_return_to] = request.url
    end
  end

  def stored_location
    session[:user_return_to]
  end

  def redirect_to_stored_location
    if stored_location
      redirect_to stored_location
    else
      redirect_to weixin_static_url(:info), alert: "该账号没有绑定微信，请绑定以后继续使用。#{ view_context.link_to '立即绑定', '/auth/wechat' }"
    end
  end

  def sign_in(user)
    user_return_to = stored_location
    reset_session
    session[:user_id] = user.id
    session[:user_return_to] = user_return_to

    Rails.logger.info "user_id in session is: #{session[:user_id]}"
    Rails.logger.info "stored location is: #{stored_location}"

    redirect_to_stored_location
  end

  def lecturer_required
    return if anonymous_allowed?

    if !current_user.teacher?
      redirect_to new_weixin_session_url, alert: '您没有足够的权限查看该页面，请重新登录'
    end
  end

  def redirect_to_participation_required_url
    redirect_to new_weixin_session_url, alert: '您没有参加该培训项目，暂不能参加此项活动！'
  end

  def admin_allowed?
    request.get? && current_user.admin?
  end

  def anonymous_allowed?
    false
  end
end
