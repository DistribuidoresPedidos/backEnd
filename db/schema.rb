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

ActiveRecord::Schema.define(version: 20170330201457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "cube"
  enable_extension "earthdistance"

  create_table "comments", force: :cascade do |t|
    t.string   "title",        null: false
    t.text     "content",      null: false
    t.date     "dateComment"
    t.integer  "calification"
    t.integer  "order_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["order_id"], name: "index_comments_on_order_id", using: :btree
  end

  create_table "coordinates", force: :cascade do |t|
    t.float    "lat"
    t.float    "lng"
    t.integer  "route_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "ll_to_earth(lat, lng)", name: "coordinates_earthdistance_ix", using: :gist
    t.index ["route_id"], name: "index_coordinates_on_route_id", using: :btree
  end

  create_table "distributors", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name",                                     null: false
    t.string   "email",                                    null: false
    t.string   "phoneNumber",                              null: false
    t.string   "photo",                                    null: false
    t.float    "latitude"
    t.float    "longitude"
    t.json     "tokens"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["confirmation_token"], name: "index_distributors_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_distributors_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_distributors_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_distributors_on_uid_and_provider", unique: true, using: :btree
  end

  create_table "offered_products", force: :cascade do |t|
    t.float    "price",          null: false
    t.integer  "product_id"
    t.integer  "distributor_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["distributor_id"], name: "index_offered_products_on_distributor_id", using: :btree
    t.index ["product_id"], name: "index_offered_products_on_product_id", using: :btree
  end

  create_table "order_products", force: :cascade do |t|
    t.float    "quantity",           null: false
    t.float    "price",              null: false
    t.integer  "offered_product_id"
    t.integer  "order_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["offered_product_id"], name: "index_order_products_on_offered_product_id", using: :btree
    t.index ["order_id"], name: "index_order_products_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.string   "state",       null: false
    t.date     "exitDate"
    t.date     "arrivalDate"
    t.float    "totalPrice",  null: false
    t.integer  "retailer_id"
    t.integer  "route_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["retailer_id"], name: "index_orders_on_retailer_id", using: :btree
    t.index ["route_id"], name: "index_orders_on_route_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "category",   null: false
    t.float    "weight",     null: false
    t.string   "photo",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "retailers", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name",                                     null: false
    t.text     "description"
    t.string   "email",                                    null: false
    t.string   "phoneNumber",                              null: false
    t.string   "photo"
    t.float    "latitude"
    t.float    "longitude"
    t.json     "tokens"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["confirmation_token"], name: "index_retailers_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_retailers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_retailers_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_retailers_on_uid_and_provider", unique: true, using: :btree
  end

  create_table "routes", force: :cascade do |t|
    t.string   "name",           null: false
    t.integer  "distributor_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["distributor_id"], name: "index_routes_on_distributor_id", using: :btree
  end

  add_foreign_key "comments", "orders"
  add_foreign_key "coordinates", "routes"
  add_foreign_key "offered_products", "distributors"
  add_foreign_key "offered_products", "products"
  add_foreign_key "order_products", "offered_products"
  add_foreign_key "order_products", "orders"
  add_foreign_key "orders", "retailers"
  add_foreign_key "orders", "routes"
  add_foreign_key "routes", "distributors"
end
