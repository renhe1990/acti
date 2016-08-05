class AddTypeAndDescriptionToEvents < ActiveRecord::Migration
  def change
    add_column :events, :type, :string
    add_column :events, :description, :text
  end
end
