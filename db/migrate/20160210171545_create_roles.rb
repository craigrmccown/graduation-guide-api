class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, null: false
    end

    create_table :roles_users do |t|
      t.integer :role_id, null: false
      t.integer :user_id, null: false
    end

    add_foreign_key :roles_users, :roles
    add_foreign_key :roles_users, :users
  end
end
