class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name, index: true
      t.string :province_id, index: true
      t.integer :level, index: true
      t.string :zip_code, index: true
      t.string :pinyin, index: true
      t.string :pinyin_abbr, index: true

      t.timestamps
    end
  end
end
