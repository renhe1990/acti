class UsersController < BaseController
  layout 'blank', only: [:new, :create]

  skip_before_action :signed_in_required, only: [:new, :create]
  skip_before_action :teacher_required, only: [:new, :create]
  skip_after_action :verify_authorized

  before_action :build_user, only: [:new, :create]
  before_action :find_roles
  before_action :find_grades, only: [:edit, :update]
  before_action :find_user, only: [:edit, :update]
  # do not move these before build_user or find_user. They uses @user to find results.
  before_action :find_provinces, only: [:new, :create, :edit, :update]
  before_action :find_cities, only: [:new, :create, :edit, :update]

  def new
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash.now[:notice] = '个人信息更新成功'
      render :edit
    else
      render :edit
    end
  end

  def create
    if @user.save
      reset_session
      flash[:notice] = '没有任何角色，暂时无法登录'
      redirect_to sign_in_url
      # session[:user_id] = @user.id
      # flash[:notice] = <<-eos
        # <p>恭喜你已成功注册成为安利励学堂用户！</p>
        # <p>您可点击右侧的“发起新课程”按钮，创建自己的课程。您发起的新课程将显示在下面的课程安排的日历中。</p>
        # <p>您可以进入“课程管理”，查看和管理公开课程和自己的课程；如果有疑问可在“社区问答”中提问寻求解答或帮助他人；在“互动管理”中您可以管理编辑课程所需的试卷和问卷，以及查看结果。</p>
      # eos
      # redirect_to root_url
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:card_number, :name, :password, :password_confirmation, :mobile, :email, :province_id, :city_id, :grade_id, :gender, :diet)
  end

  def build_user
    @user = params[:user] ? User.new(user_params) : User.new
  end

  def find_roles
    @roles = Role.all
  end

  def find_grades
    @grades = Grade.all
  end

  def find_user
    @user = User.find(params[:id])
  end

  def find_provinces
    @provinces = Province.all
  end

  def find_cities
    @cities = @user.province.try(:cities)
  end
end
