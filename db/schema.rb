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

ActiveRecord::Schema.define(version: 20160423024927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_groups", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_groups_courses", force: :cascade do |t|
    t.integer "course_id",       null: false
    t.integer "course_group_id", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description", null: false
    t.integer  "hours",       null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "prereq_id"
  end

  create_table "courses_prereqs", force: :cascade do |t|
    t.integer "prereq_id", null: false
    t.integer "course_id", null: false
  end

  add_index "courses_prereqs", ["prereq_id", "course_id"], name: "index_courses_prereqs_on_prereq_id_and_course_id", unique: true, using: :btree

  create_table "courses_users", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "user_id",   null: false
  end

  add_index "courses_users", ["course_id", "user_id"], name: "index_courses_users_on_course_id_and_user_id", unique: true, using: :btree

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

  create_table "prereqs", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "op",         null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requirement_rules", force: :cascade do |t|
    t.integer  "requirement_id",  null: false
    t.integer  "course_id"
    t.integer  "quantity"
    t.string   "rule_type",       null: false
    t.integer  "priority",        null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "course_group_id"
  end

  add_index "requirement_rules", ["requirement_id", "priority"], name: "index_requirement_rules_on_requirement_id_and_priority", unique: true, using: :btree

  create_table "requirements", force: :cascade do |t|
    t.integer  "major_id"
    t.integer  "track_id"
    t.integer  "minor_id"
    t.integer  "parent_id"
    t.string   "op",         null: false
    t.integer  "priority",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "requirements", ["parent_id", "priority"], name: "index_requirements_on_parent_id_and_priority", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "roles_users", force: :cascade do |t|
    t.integer "role_id", null: false
    t.integer "user_id", null: false
  end

  add_index "roles_users", ["user_id", "role_id"], name: "index_roles_users_on_user_id_and_role_id", unique: true, using: :btree

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

  add_foreign_key "course_groups_courses", "course_groups"
  add_foreign_key "course_groups_courses", "courses"
  add_foreign_key "courses", "prereqs"
  add_foreign_key "courses_prereqs", "courses"
  add_foreign_key "courses_prereqs", "prereqs"
  add_foreign_key "courses_users", "courses"
  add_foreign_key "courses_users", "users"
  add_foreign_key "majors_users", "majors"
  add_foreign_key "majors_users", "users"
  add_foreign_key "minors_users", "minors"
  add_foreign_key "minors_users", "users"
  add_foreign_key "prereqs", "prereqs", column: "parent_id"
  add_foreign_key "requirement_rules", "course_groups"
  add_foreign_key "requirement_rules", "courses"
  add_foreign_key "requirement_rules", "requirements"
  add_foreign_key "requirements", "majors"
  add_foreign_key "requirements", "minors"
  add_foreign_key "requirements", "requirements", column: "parent_id"
  add_foreign_key "requirements", "tracks"
  add_foreign_key "roles_users", "roles"
  add_foreign_key "roles_users", "users"
  add_foreign_key "tracks", "majors"
  add_foreign_key "tracks_users", "tracks"
  add_foreign_key "tracks_users", "users"
end
