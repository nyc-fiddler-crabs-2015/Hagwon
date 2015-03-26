class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name, null: false
      t.references :user, null: false
      t.references :category, null: false

      t.timestamps null: false
    end
  end
end
