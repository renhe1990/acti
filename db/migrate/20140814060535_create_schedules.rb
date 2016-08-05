class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.date :date
      t.string :title
      t.string :hint
      t.references :section

      t.timestamps
    end
  end
end
