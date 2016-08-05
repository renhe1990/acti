class Weixin::TextArticlesController < Weixin::BaseController
  def show
    @article = TextArticle.find(params[:id])
  end
end
