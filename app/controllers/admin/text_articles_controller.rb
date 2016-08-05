class Admin::TextArticlesController < Admin::ArticlesController
  def new
    @article = TextArticle.new
    authorize @article
  end

  def create
    @article = TextArticle.new(article_params)
    authorize @article

    if params[:preview_button]
      render 'show'
    else
      if params[:publish_button]
        @article.status = :published
      end

      if @article.save
        flash[:notice] = params[:publish_button] ? '图文消息内容发布成功' : '图文消息内容保存成功'
        redirect_to [:admin, @article]
      else
        render 'new'
      end
    end
  end

  def update
    @article = Article.find(params[:id])
    authorize @article

    if params[:preview_button]
      render 'show'
    else
      if params[:publish_button]
        @article.status = :published
      end

      if @article.update_attributes article_params
        flash[:notice] = params[:publish_button] ? '图文消息内容发布成功' : '图文消息内容保存成功'
        redirect_to [:admin, @article]
      else
        render 'edit'
      end
    end
  end

  protected
  def article_params
    params.require(:text_article).permit(:title, :body, :keyword_list, :article_category_id)
  end
end
