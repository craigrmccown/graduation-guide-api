class CoursesUsers < ActiveRecord::Migration
  def change
    create_table :courses_users do |t|
      t.integer :course_id, null: false
      t.integer :user_id, null: false
    end

    add_foreign_key :courses_users, :courses
    add_foreign_key :courses_users, :users
    add_index :courses_users, [:course_id, :user_id], unique: true
  end
end
