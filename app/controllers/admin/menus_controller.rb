class Admin::MenusController < Admin::BaseController
  include Admin::Sortable

  before_action :find_and_authorzie_menu, only: [:show, :edit, :update, :destroy]
  before_action :find_parent, only: [:new, :create]

  def index
    @menus = policy_scope(Menu.roots).all

    authorize @menus
  end

  def new
    @menu = Menu.new
    authorize @menu
  end

  def create
    @menu = Menu.new(menu_params.merge(parent: @parent))
    authorize @menu

    if @menu.save
      redirect_to [:admin, :menus], notice: '微信菜单创建成功'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @menu.update_attributes menu_params
      redirect_to [:admin, :menus], notice: '微信菜单更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @menu.destroy
    redirect_to [:admin, :menus], notice: '微信菜单删除成功'
  end

  def publish
    authorize Menu

    if Menu.publish
      redirect_to [:admin, :menus], notice: '微信菜单发布成功'
    else
      redirect_to [:admin, :menus], notice: '微信菜单发布失败'
    end
  end

  private

    def find_and_authorzie_menu
      @menu = Menu.find(params[:id])

      authorize @menu
    end

    def find_parent
      @parent = Menu.where(id: params[:parent_id]).first
    end

    def menu_params
      params.require(:menu).permit(:name, :category, :url, :title, :description, :image)
    end
end
