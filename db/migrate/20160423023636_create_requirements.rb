class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.integer :course_id
      t.integer :major_id
      t.integer :track_id
      t.integer :minor_id
      t.integer :parent_id
      t.integer :quantity
      t.string :req_type, null: false
      t.string :op
      t.string :description
      t.timestamps null: false
    end

    add_foreign_key :requirements, :courses
    add_foreign_key :requirements, :majors
    add_foreign_key :requirements, :tracks
    add_foreign_key :requirements, :minors
    add_foreign_key :requirements, :requirements, column: :parent_id
  end
end
