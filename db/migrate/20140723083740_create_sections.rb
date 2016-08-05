class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :project
      t.text :description

      t.timestamps
    end
  end
end
