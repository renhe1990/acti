class CreateOpinionnaireReviewees < ActiveRecord::Migration
  def change
    create_table :opinionnaire_reviewees do |t|
      t.references :opinionnaire
      t.references :reviewee
      t.integer :position, default: 1

      t.timestamps
    end
  end
end
