class CreateProvinces < ActiveRecord::Migration
  def change
    create_table :provinces do |t|
      t.string :name
      t.string :pinyin
      t.string :pinyin_abbr

      t.timestamps
    end
  end
end
