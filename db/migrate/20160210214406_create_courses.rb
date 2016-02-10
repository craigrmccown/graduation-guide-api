class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.timestamps null: false
    end

    create_table :courses_majors do |t|
      t.integer :course_id, null: false
      t.integer :major_id, null: false
    end

    create_table :courses_minors do |t|
      t.integer :course_id, null: false
      t.integer :minor_id, null: false
    end

    create_table :courses_tracks do |t|
      t.integer :course_id, null: false
      t.integer :track_id, null: false
    end

    add_foreign_key :courses_majors, :courses
    add_foreign_key :courses_majors, :majors
    add_index :courses_majors, [:course_id, :major_id], unique: true

    add_foreign_key :courses_minors, :courses
    add_foreign_key :courses_minors, :minors
    add_index :courses_minors, [:course_id, :minor_id], unique: true

    add_foreign_key :courses_tracks, :courses
    add_foreign_key :courses_tracks, :tracks
    add_index :courses_tracks, [:course_id, :track_id], unique: true
  end
end
