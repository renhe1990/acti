class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :title
      t.string :video
      t.string :video_screenshot
      t.string :cover

      t.timestamps
    end
  end
end
