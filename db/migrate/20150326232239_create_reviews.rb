class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.integer :difficulty, null: false
      t.text :comment, null: false
      t.references :course, null: false

      t.timestamps null: false
    end
  end
end
