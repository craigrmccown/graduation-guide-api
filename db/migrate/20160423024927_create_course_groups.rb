class CreateCourseGroups < ActiveRecord::Migration
  def change
    create_table :course_groups do |t|
      t.string :name, null: false
      t.timestamps null: false
    end

    create_table :course_groups_courses do |t|
      t.integer :course_id, null: false
      t.integer :course_group_id, null: false
    end

    add_column :requirement_rules, :course_group_id, :integer
    add_foreign_key :course_groups_courses, :courses
    add_foreign_key :course_groups_courses, :course_groups
    add_foreign_key :requirement_rules, :course_groups
  end
end
