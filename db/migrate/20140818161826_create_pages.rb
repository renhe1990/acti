class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :slug, index: true
      t.text :body

      t.timestamps
    end
  end
end
