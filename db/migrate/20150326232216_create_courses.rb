class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :url, null: false
      t.string :name, null: false
      t.references :category

      t.timestamps null: false
    end
  end
end
