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

ActiveRecord::Schema.define(version: 20200505204915) do

  create_table "brokers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "password"
    t.string "email"
    t.string "telephone"
  end

  create_table "companies", force: :cascade do |t|
    t.string "ticker"
    t.string "name"
    t.float  "current_price"
  end

  create_table "investors", force: :cascade do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "username"
    t.string  "password"
    t.integer "broker_id"
    t.float   "account_cash"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "investor_id"
    t.integer  "company_id"
    t.datetime "transaction_date"
    t.float    "price"
    t.integer  "quantity"
    t.boolean  "is_purchase?"
  end

end
