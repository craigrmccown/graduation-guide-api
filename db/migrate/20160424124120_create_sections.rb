class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :course_id, null: false
      t.integer :crn, null: false
      t.string :days, null: false
      t.integer :start, null: false
      t.integer :end, null: false
      t.string :professor, null: false
      t.timestamps null: false
    end

    add_foreign_key :sections, :courses
  end
end
