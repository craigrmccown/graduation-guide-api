# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160210214406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "courses_majors", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "major_id",  null: false
  end

  add_index "courses_majors", ["course_id", "major_id"], name: "index_courses_majors_on_course_id_and_major_id", unique: true, using: :btree

  create_table "courses_minors", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "minor_id",  null: false
  end

  add_index "courses_minors", ["course_id", "minor_id"], name: "index_courses_minors_on_course_id_and_minor_id", unique: true, using: :btree

  create_table "courses_tracks", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "track_id",  null: false
  end

  add_index "courses_tracks", ["course_id", "track_id"], name: "index_courses_tracks_on_course_id_and_track_id", unique: true, using: :btree

  create_table "majors", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "majors_users", force: :cascade do |t|
    t.integer "major_id", null: false
    t.integer "user_id",  null: false
  end

  add_index "majors_users", ["user_id", "major_id"], name: "index_majors_users_on_user_id_and_major_id", unique: true, using: :btree

  create_table "minors", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "minors_users", force: :cascade do |t|
    t.integer "minor_id"
    t.integer "user_id"
  end

  add_index "minors_users", ["user_id", "minor_id"], name: "index_minors_users_on_user_id_and_minor_id", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "roles_users", force: :cascade do |t|
    t.integer "role_id", null: false
    t.integer "user_id", null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.integer  "major_id",    null: false
    t.string   "name",        null: false
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tracks_users", force: :cascade do |t|
    t.integer "track_id", null: false
    t.integer "user_id",  null: false
  end

  add_index "tracks_users", ["user_id", "track_id"], name: "index_tracks_users_on_user_id_and_track_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",              null: false
    t.string   "encrypted_password", null: false
    t.string   "first_name",         null: false
    t.string   "last_name",          null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_foreign_key "courses_majors", "courses"
  add_foreign_key "courses_majors", "majors"
  add_foreign_key "courses_minors", "courses"
  add_foreign_key "courses_minors", "minors"
  add_foreign_key "courses_tracks", "courses"
  add_foreign_key "courses_tracks", "tracks"
  add_foreign_key "majors_users", "majors"
  add_foreign_key "majors_users", "users"
  add_foreign_key "minors_users", "minors"
  add_foreign_key "minors_users", "users"
  add_foreign_key "roles_users", "roles"
  add_foreign_key "roles_users", "users"
  add_foreign_key "tracks", "majors"
  add_foreign_key "tracks_users", "tracks"
  add_foreign_key "tracks_users", "users"
end
