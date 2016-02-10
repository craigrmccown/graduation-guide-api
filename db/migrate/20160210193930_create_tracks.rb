class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :major_id, null: false
      t.string :name, null: false
      t.string :description, null: false
      t.timestamps null: false
    end

    create_table :tracks_users do |t|
      t.integer :track_id, null: false
      t.integer :user_id, null: false
    end

    add_foreign_key :tracks, :majors
    add_foreign_key :tracks_users, :tracks
    add_foreign_key :tracks_users, :users
    add_index :tracks_users, [:user_id, :track_id], unique: true
  end
end
