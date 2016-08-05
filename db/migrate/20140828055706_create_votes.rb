class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :title
      t.text :description
      t.references :course, index: true

      t.timestamps
    end
  end
end
