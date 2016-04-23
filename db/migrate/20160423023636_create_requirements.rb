class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.integer :major_id
      t.integer :track_id
      t.integer :minor_id
      t.integer :priority, null: false
      t.string :description
      t.timestamps null: false
    end

    create_table :requirement_rules do |t|
      t.integer :requirement_id
      t.integer :course_id
      t.integer :parent_id
      t.integer :quantity
      t.string :op
      t.string :req_type
      t.timestamps null: false
    end

    add_foreign_key :requirements, :majors
    add_foreign_key :requirements, :tracks
    add_foreign_key :requirements, :minors
    add_foreign_key :requirement_rules, :requirements
    add_foreign_key :requirement_rules, :courses
    add_foreign_key :requirement_rules, :requirement_rules, column: :parent_id
  end
end
