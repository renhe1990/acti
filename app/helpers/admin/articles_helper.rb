module Admin::ArticlesHelper
  def build_article_filter_url(field, value)
    copy_params = params.slice(:article_category_id, :status)
    copy_params[field] = value
    admin_articles_url(copy_params)
  end

  def link_to_article_filter(name, field, value)
    selected = (params[field].presence == value.to_s)
    if selected
      name
    else
      link_to name, build_article_filter_url(field, value), class: "#{'selected' if selected}"
    end
  end
end
