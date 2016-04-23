class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.integer :hours, null: false
      t.timestamps null: false
    end
  end
end
