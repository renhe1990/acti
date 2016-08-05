class Weixin::BindingsController < Weixin::BaseController
  before_action :find_openid, only: [:new, :create]
  before_action :find_force, only: [:new, :create]

  def new
    if current_user
      @user = current_user
      @user.provider = 'wechat'
      @user.uid = @openid
      @user.save validate: false
    else
      @user = User.by_uid(@openid).first
    end
  end

  def create
    @user = User.authenticate user_params[:card_number], user_params[:password]
    if @user
      # FIXME: find a better way to skip validations
      @user.provider = 'wechat'
      @user.uid = @openid
      @user.save validate: false

      if stored_location
        sign_in @user
      else
        session[:user_id] = @user.id
        redirect_to weixin_binding_url(@user.id)
      end
    else
      flash.now[:alert] = %Q{
        <strong>用户名和密码不匹配</strong>
        <ol style='padding-left: 20px; padding-bottom: 0px'>
          <li>您可能暂未受邀参加ACTI的培训;</li>
          <li>您可能忘记在安利卡后后面添加性别码。（男性添加1，女性添加0） </li>
        </ol>
      }
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def find_wechat_user
    @wechat_user = Wechat.api.user @openid rescue nil
    unless @wechat_user
      flash.now[:alert] = '无法找到微信用户'
      render 'new'
    end
  end

  def find_openid
    @openid = params[:openid]
  end

  def user_params
    @user_params ||= params.require(:user).permit(:card_number, :password)
  end

  def find_force
    @force = !!params[:force]
  end
end
