class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :participateable, polymorphic: true, index: { name: 'index_participations_on_participateable' }
      t.references :user, index: true

      t.timestamps
    end
  end
end
