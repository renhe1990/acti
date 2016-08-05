class SessionsController < BaseController
  layout 'blank'

  skip_before_action :signed_in_required, only: [:new, :create]
  skip_after_action :verify_authorized,  except: :index
  skip_after_action :verify_policy_scoped, only: :index
  skip_before_action :admin_required
  skip_before_action :teacher_required

  def new
    @user = User.new
  end

  def create
    @user = User.authenticate user_params[:card_number], user_params[:password]

    if @user
      if @user.deleted?
        flash.now[:alert] = '该账号已被冻结!'
        render 'new'
      else
        reset_session
        session[:user_id] = @user.id
        if @user.role.nil?
          flash.now[:alert] = '没有任何角色，暂时无法登录'
          render 'new'
        else
          if @user.admin?
            redirect_to [:admin, :root]
          else
            redirect_to [:root]
          end
        end
      end
    else
      flash.now[:alert] = '无效的用户名或者密码, 请重新输入'
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to sign_in_url
  end

  def failure
    redirect_to root_url, alert: '无法登录, 请重新尝试'
  end

  private
  def user_params
    @user_params ||= params.require(:user).permit(:card_number, :password)
  end
end
