class Admin::ArticlesController < Admin::BaseController
  before_action :find_article_categories, only: [:index, :new, :create, :edit, :update]

  def index
    @keyword = params[:keyword].presence

    @total = policy_scope(Article).count_by_keyword(@keyword)
    @articles = policy_scope(Article).search(@keyword, params).page(params[:page])
  end

  def show
    @article = Article.find(params[:id])
    authorize @article
  end

  def edit
    @article = Article.find(params[:id])
    authorize @article
  end

  def destroy
    @article = Article.find(params[:id])
    authorize @article

    @article.destroy
    redirect_to [:admin, :articles]
  end

  protected
  def article_params
    params.require(:article).permit(:title, :body, :keyword_list)
  end

  def find_article_categories
    @article_categories = ArticleCategory.all
  end
end
