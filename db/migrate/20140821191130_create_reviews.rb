class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :context, polymorphic: true, index: true
      t.references :reviewable, polymorphic: true, index: true
      t.references :reviewer, polymorphic: true, index: true

      t.timestamps
    end
  end
end
