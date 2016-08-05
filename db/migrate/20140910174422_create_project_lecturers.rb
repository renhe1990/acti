class CreateProjectLecturers < ActiveRecord::Migration
  def change
    create_table :project_lecturers do |t|
      t.references :project, index: true
      t.references :lecturer, index: true
      t.integer :position

      t.timestamps
    end
  end
end
