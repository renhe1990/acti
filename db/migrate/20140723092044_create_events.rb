class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :section
      t.string :name
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :location

      t.timestamps
    end
  end
end
