class AddVideoToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :video, :string
  end
end
