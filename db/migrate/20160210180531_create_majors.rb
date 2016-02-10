class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.timestamps null: false
    end

    create_table :majors_users do |t|
      t.integer :major_id, null: false
      t.integer :user_id, null: false
    end

    add_foreign_key :majors_users, :majors
    add_foreign_key :majors_users, :users
    add_index :majors_users, [:user_id, :major_id], unique: true
  end
end
