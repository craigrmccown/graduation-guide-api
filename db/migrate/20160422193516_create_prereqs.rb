class CreatePrereqs < ActiveRecord::Migration
  def change
    create_table :prereqs do |t|
      t.integer :course_id
      t.integer :parent_id
      t.string  :op, null: false
      t.timestamps null: false
    end

    create_table :courses_prereqs do |t|
      t.integer :prereq_id, null: false
      t.integer :course_id, null: false
    end

    add_foreign_key :prereqs, :prereqs, column: :parent_id
    add_foreign_key :prereqs, :courses
    add_foreign_key :courses_prereqs, :prereqs
    add_foreign_key :courses_prereqs, :courses
  end
end
