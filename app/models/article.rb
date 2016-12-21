class Article < DatabaseConnection
  enum status: { draft: 0, published: 1 }

  validates :title, presence: true

  acts_as_taggable_on :keywords

  belongs_to :article_category

  scope :by_keyword, ->(keyword) {
    select("DISTINCT articles.*").joins(:taggings => :tag).where("articles.title LIKE ? OR tags.name = ?", "%#{keyword}%", keyword)
  }
  scope :by_article_category, ->(article_category_id) { where(article_category_id: article_category_id) }
  scope :by_status, ->(status) { where(status: status) }

  def for_wechat?
    return false if self.article_category.nil?

    self.article_category.name == '推送文章'
  end

  def status_to_s
    case status.to_sym
    when :published
      '已发布'
    when :draft
      '草稿'
    end
  end

  def self.count_by_keyword(keyword)
    select("DISTINCT articles.id").joins(:taggings => :tag).where("articles.title LIKE ? OR tags.name = ?", "%#{keyword}%", keyword).count
  end

  def self.policy_class
    ApplicationPolicy
  end

  def self.search(keyword, options)
    scoping = Article.includes(:article_category)
    scoping = scoping.by_keyword(keyword) if keyword.present?
    scoping = scoping.by_article_category(options[:article_category_id]) if options[:article_category_id].present?
    scoping = scoping.by_status(Article.statuses[options[:status]]) if options[:status].present?

    scoping
  end
end
