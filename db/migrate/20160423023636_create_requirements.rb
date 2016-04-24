class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.integer :major_id
      t.integer :track_id
      t.integer :minor_id
      t.integer :parent_id
      t.string :op, null: false
      t.integer :priority, null: false
      t.timestamps null: false
    end

    create_table :requirement_rules do |t|
      t.integer :requirement_id, null: false
      t.integer :course_id
      t.integer :quantity
      t.string :rule_type, null: false
      t.integer :priority, null: false
      t.timestamps null: false
    end

    add_foreign_key :requirements, :majors
    add_foreign_key :requirements, :tracks
    add_foreign_key :requirements, :minors
    add_foreign_key :requirements, :requirements, column: :parent_id
    add_foreign_key :requirement_rules, :requirements
    add_foreign_key :requirement_rules, :courses
    add_index :requirements, [:parent_id, :priority], unique: true
    add_index :requirement_rules, [:requirement_id, :priority], unique: true
  end
end
