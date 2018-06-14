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

ActiveRecord::Schema.define(version: 20171229175345) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comics", force: :cascade do |t|
    t.integer "num"
    t.string "title", null: false
    t.string "safe_title", null: false
    t.string "img_url", null: false
    t.text "alt_text"
    t.string "day"
    t.string "month"
    t.string "year"
    t.text "transcript"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "email_receipts", force: :cascade do |t|
    t.integer "num"
    t.bigint "subscriber_id", null: false
    t.bigint "comic_id", null: false
    t.bigint "subscription_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comic_id"], name: "index_email_receipts_on_comic_id"
    t.index ["num"], name: "index_email_receipts_on_num"
    t.index ["subscriber_id"], name: "index_email_receipts_on_subscriber_id"
    t.index ["subscription_id"], name: "index_email_receipts_on_subscription_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "subscriber_id", null: false
    t.bigint "comic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comic_id"], name: "index_favorites_on_comic_id"
    t.index ["subscriber_id"], name: "index_favorites_on_subscriber_id"
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "firstname"
    t.string "email", null: false
    t.boolean "verified"
    t.boolean "super", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "subs_name", null: false
    t.string "label"
    t.string "active"
    t.bigint "subscriber_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscriber_id"], name: "index_subscriptions_on_subscriber_id"
  end

  add_foreign_key "email_receipts", "comics"
  add_foreign_key "email_receipts", "subscribers"
  add_foreign_key "email_receipts", "subscriptions"
  add_foreign_key "favorites", "comics"
  add_foreign_key "favorites", "subscribers"
  add_foreign_key "subscriptions", "subscribers"
end
