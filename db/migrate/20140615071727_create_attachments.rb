class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :attachable, polymorphic: true, index: true
      t.string :asset
      t.string :content_type
      t.integer :file_size

      t.timestamps
    end
  end
end
