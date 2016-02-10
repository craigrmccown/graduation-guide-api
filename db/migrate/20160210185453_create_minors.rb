class CreateMinors < ActiveRecord::Migration
  def change
    create_table :minors do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.timestamps null: false
    end

    create_table :minors_users do |t|
      t.integer :minor_id
      t.integer :user_id
    end

    add_foreign_key :minors_users, :minors
    add_foreign_key :minors_users, :users
    add_index :minors_users, [:user_id, :minor_id], unique: true
  end
end
