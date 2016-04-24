class CreatePrereqs < ActiveRecord::Migration
  def change
    create_table :prereqs do |t|
      t.integer :parent_id
      t.string  :op, null: false
      t.timestamps null: false
    end

    create_table :courses_prereqs do |t|
      t.integer :prereq_id, null: false
      t.integer :course_id, null: false
    end

    add_column :courses, :prereq_id, :integer
    add_foreign_key :courses, :prereqs
    add_foreign_key :prereqs, :prereqs, column: :parent_id
    add_foreign_key :courses_prereqs, :prereqs
    add_foreign_key :courses_prereqs, :courses
    add_index :courses_prereqs, [:prereq_id, :course_id], unique: true
  end
end
