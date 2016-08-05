class CreateLuckyDraws < ActiveRecord::Migration
  def change
    create_table :lucky_draws do |t|
      t.references :course
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
