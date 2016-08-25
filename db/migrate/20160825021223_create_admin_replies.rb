class CreateAdminReplies < ActiveRecord::Migration
  def change
    create_table :admin_replies do |t|
      t.string :category
      t.text :data

      t.timestamps
    end
  end
end
