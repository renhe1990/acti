class ArticleCategory < DatabaseConnection
  validates :name, presence: true, uniqueness: true

  has_many :articles
end
