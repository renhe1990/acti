class Weixin::PagesController < Weixin::BaseController
  layout 'page'

  def show
    @page = Page.where(slug: params[:id]).first
  end
end
