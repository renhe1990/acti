class Weixin::SessionsController < Weixin::BaseController
  def new
  end

  def create
    @user = User.authenticate user_params[:card_number], user_params[:password]
    if @user
      if @user.deleted?
        flash.now[:alert] = '该账号已被冻结!'
        render 'new'
      else
        sign_in @user
      end
    else
      flash.now[:alert] = %Q{
        <strong>用户名和密码不匹配</strong>
        <ol style='padding-left: 20px; padding-bottom: 0px'>
          <li>您可能暂未受邀参加ACTI的培训;</li>
          <li>您可能忘记在安利卡后后面添加性别码。（男性添加1，女性添加0） </li>
        </ol>
      }
      render :new
    end
  end

  def callback
    logger.info auth_hash
    redirect_to new_weixin_binding_url(openid: auth_hash['uid'])
  end

  def failure
    redirect_to_stored_location
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  private

  def user_params
    @user_params ||= params.require(:user).permit(:card_number, :password)
  end
end
