class CreateCourseGroups < ActiveRecord::Migration
  def change
    create_table :course_groups do |t|
      t.string :name, null: false
      t.timestamps null: false
    end

    add_column :courses, :course_group_id, :integer
    add_column :requirements, :course_group_id, :integer
    add_foreign_key :courses, :course_groups
    add_foreign_key :requirements, :course_groups
  end
end
