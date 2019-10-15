# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_14_221252) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chanel_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chanel_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chanel_id"], name: "index_chanel_users_on_chanel_id"
    t.index ["user_id"], name: "index_chanel_users_on_user_id"
  end

  create_table "chanels", force: :cascade do |t|
    t.string "title"
    t.boolean "is_group"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chanel_id", null: false
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chanel_id"], name: "index_messages_on_chanel_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.boolean "is_accepted"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "sender_id"
    t.bigint "receiver_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "email"
    t.string "password_digest"
    t.string "picture_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["user_name"], name: "index_users_on_user_name", unique: true
  end

  add_foreign_key "chanel_users", "chanels"
  add_foreign_key "chanel_users", "users"
  add_foreign_key "messages", "chanels"
  add_foreign_key "messages", "users"
  add_foreign_key "requests", "users", column: "receiver_id"
  add_foreign_key "requests", "users", column: "sender_id"
end
