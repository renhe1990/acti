class Weixin::VideoArticlesController < Weixin::BaseController
  def show
    @article = VideoArticle.find(params[:id])
  end
end
