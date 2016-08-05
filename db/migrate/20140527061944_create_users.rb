class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :card_number
      t.string :name
      t.string :password_digest
      t.string :mobile
      t.string :email

      t.timestamps
    end
  end
end
