class Admin::PagesController < Admin::BaseController
  before_action :find_page, only: [:edit, :update, :destroy]

  def index
    @pages = policy_scope(Page).page(params[:page]).per(20)

    authorize @pages
  end

  def edit
    authorize @page
  end

  def update
    authorize @page
    if @page.update_attributes page_params
      redirect_to [:admin, :pages], notice: '静态页面编辑成功'
    else
      render 'edit'
    end
  end

  private
  def find_page
    @page = Page.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:body)
  end
end
