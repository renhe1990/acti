class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :image
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
