class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :photoable, polymorphic: true, index: true
      t.string :image
      t.string :content_type
      t.string :file_size

      t.timestamps
    end
  end
end
