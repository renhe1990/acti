class ArticleCategory < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :articles
end
