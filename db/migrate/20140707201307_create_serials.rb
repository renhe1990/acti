class CreateSerials < ActiveRecord::Migration
  def change
    create_table :serials do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
