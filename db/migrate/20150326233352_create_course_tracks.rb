class CreateCourseTracks < ActiveRecord::Migration
  def change
    create_table :course_tracks do |t|
      t.integer :order
      t.references :course, null: false
      t.references :track, null: false

      t.timestamps null: false
    end
  end
end
