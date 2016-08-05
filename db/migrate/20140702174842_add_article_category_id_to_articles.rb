class AddArticleCategoryIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :article_category_id, :integer
    add_index :articles, :article_category_id
  end
end
