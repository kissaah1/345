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

ActiveRecord::Schema.define(version: 20160528202727) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allies", force: :cascade do |t|
    t.string   "name"
    t.text     "descriptions"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "allies", ["user_id", "created_at"], name: "index_allies_on_user_id_and_created_at", using: :btree
  add_index "allies", ["user_id"], name: "index_allies_on_user_id", using: :btree

  create_table "allies_users", id: false, force: :cascade do |t|
    t.integer "ally_id"
    t.integer "user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "industry"
    t.string   "website"
    t.text     "summary"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "picture"
  end

  add_index "companies", ["user_id", "created_at"], name: "index_companies_on_user_id_and_created_at", using: :btree
  add_index "companies", ["user_id"], name: "index_companies_on_user_id", using: :btree

  create_table "employments", force: :cascade do |t|
    t.boolean  "senior"
    t.boolean  "manager"
    t.boolean  "staff"
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "employments", ["company_id", "created_at"], name: "index_employments_on_company_id_and_created_at", using: :btree
  add_index "employments", ["company_id"], name: "index_employments_on_company_id", using: :btree
  add_index "employments", ["user_id", "created_at"], name: "index_employments_on_user_id_and_created_at", using: :btree
  add_index "employments", ["user_id"], name: "index_employments_on_user_id", using: :btree

  create_table "microposts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "picture"
    t.text     "survey_1"
    t.text     "survey_2"
    t.text     "survey_3"
    t.string   "survey_4"
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at", using: :btree
  add_index "microposts", ["user_id"], name: "index_microposts_on_user_id", using: :btree

  create_table "positions", force: :cascade do |t|
    t.string   "title"
    t.text     "summary"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "is_current"
    t.string   "company"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "picture"
  end

  add_index "positions", ["user_id", "created_at"], name: "index_positions_on_user_id_and_created_at", using: :btree
  add_index "positions", ["user_id"], name: "index_positions_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "location"
    t.string   "industry"
    t.string   "headline"
    t.string   "linkedin"
    t.text     "summary"
    t.text     "skills"
    t.text     "other_skills"
    t.boolean  "enthusiast",        default: false
    t.boolean  "skeptic",           default: false
    t.boolean  "navigator",         default: false
    t.boolean  "pioneer",           default: false
    t.boolean  "coach",             default: false
    t.boolean  "solo",              default: true
    t.boolean  "cadmin",            default: false
    t.string   "picture"
    t.string   "linkedin_image"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "allies", "users"
  add_foreign_key "companies", "users"
  add_foreign_key "employments", "companies"
  add_foreign_key "employments", "users"
  add_foreign_key "microposts", "users"
  add_foreign_key "positions", "users"
end
