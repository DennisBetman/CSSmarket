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

ActiveRecord::Schema.define(version: 20180415124914) do

  create_table "declined_posts", force: :cascade do |t|
    t.integer  "post_id"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "amount"
    t.string   "description"
    t.string   "customer_id"
    t.string   "source"
    t.integer  "post_id"
    t.integer  "user_id"
    t.string   "payment_type"
    t.decimal  "author_cut"
  end

  create_table "password_resets", force: :cascade do |t|
    t.string   "reset_id"
    t.integer  "user_id"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.string   "categories"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id"
    t.string   "price"
    t.string   "description"
    t.string   "image"
    t.string   "license"
    t.string   "file"
    t.integer  "status",      default: 0
    t.string   "nice_url"
    t.string   "parent_id"
  end

  create_table "seller_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content"
    t.string   "portfolio_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "level",           default: 0,     null: false
    t.string   "nano_address"
    t.decimal  "cut_percentage",  default: "0.8"
    t.string   "paypal_address"
  end

  create_table "withdrawals", force: :cascade do |t|
    t.decimal  "amount"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "status",     default: 0
  end

end
