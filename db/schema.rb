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

ActiveRecord::Schema.define(version: 20170513013727) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "participant_trips", force: :cascade do |t|
    t.integer "trip_id"
    t.boolean "primary",        default: true
    t.integer "participant_id"
    t.boolean "alternate",      default: false
    t.index ["participant_id"], name: "index_participant_trips_on_participant_id", using: :btree
  end

  create_table "participant_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "participant_id"
    t.index ["participant_id"], name: "index_participant_users_on_participant_id", using: :btree
    t.index ["user_id"], name: "index_participant_users_on_user_id", using: :btree
  end

  create_table "participants", force: :cascade do |t|
    t.string   "first_name"
    t.integer  "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "last_name"
  end

  create_table "trips", force: :cascade do |t|
    t.string  "title"
    t.string  "location"
    t.integer "seats"
    t.integer "alt_seats"
    t.date    "start_date"
    t.time    "start_time"
    t.time    "end_time"
    t.boolean "published",  default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "last_name"
    t.integer  "active_participants"
    t.boolean  "admin",                  default: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "active",                 default: true
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "participant_trips", "participants", on_delete: :cascade
end
