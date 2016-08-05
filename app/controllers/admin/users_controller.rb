class Admin::UsersController < Admin::BaseController
  before_action :find_roles
  before_action :find_areas, only: [:index, :new, :create, :edit, :update]
  before_action :find_grades, only: [:index, :new, :create, :edit, :update]
  before_action :find_user, only: [:edit, :update]
  before_action :find_provinces, only: [:new, :create, :edit, :update]
  before_action :find_cities, only: [:new, :create, :edit, :update]

  def index
    @mode = :batch if params[:mode].presence === 'batch'

    @keyword = params[:keyword].presence
    @users = policy_scope(User).search(@keyword, params.merge(with_deleted: true))
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user

    if @user.save
      flash[:notice] = '用户添加成功.'
      redirect_to [:admin, :users]
    else
      render 'new'
    end
  end

  def show
    @user = User.with_deleted.find(params[:id])
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    authorize @user

    if @user.update_attributes user_params
      respond_to do |format|
        format.html { redirect_to [:admin, @user] }
        format.json { render json: @user }
      end
    else
      respond_to do |format|
        format.html { render 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.with_deleted.find(params[:id])
    authorize @user

    @roles = Role.all
    @user.destroy

    respond_to do |format|
      format.html { redirect_to [:admin, @user], notice: '用户冻结成功.' }
      format.js
    end
  end

  def restore
    @user = User.with_deleted.find(params[:id])
    authorize @user

    @user.restore

    respond_to do |format|
      format.html { redirect_to [:admin, @user], notice: '用户恢复成功.' }
      format.js
    end
  end

  def import
    authorize User
    @users = User.import(params[:file], role_id: params[:role_id])

    respond_to do |format|
      if @users.present?
        format.html { redirect_to [:admin, :users], notice: '导入用户成功.' }
        format.json { render json: @users.map{|user| { value: user.id, text: user.name } } }
      else
        format.html { redirect_to [:admin, :users], alert: '没有导入任何用户，请重新尝试或者检查上传文件格式是否正确' }
        format.json { render json: @users.map{|user| { value: user.id, text: user.name } } }
      end
    end
  end

  def delete
    @user = User.with_deleted.find(params[:id])
    authorize @user

    @user.really_destroy!

    redirect_to [:admin, :users], notice: '用户删除成功'
  end

  private
  def user_params
    params.require(:user).permit(:name, :card_number, :province_id, :city_id, :email, :mobile, :role_id, :grade_id, :gender, :diet, :password, :password_confirmation)
  end

  def find_roles
    @roles = Role.all
  end

  def find_areas
    @areas = Area.all
  end

  def find_grades
    @grades = Grade.all
  end

  def find_user
    @user = User.with_deleted.find(params[:id])
  end

  def find_provinces
    @provinces = Province.all
  end

  def find_cities
    if @user
      @cities = @user.province.try(:cities)
    else
      []
    end
  end
end
