class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :url, null: false
      t.string :name, null: false
      t.references :category
      t.string :photo_url
      t.references :platform

      t.timestamps null: false
    end
  end
end
