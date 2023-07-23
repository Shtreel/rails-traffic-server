# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_23_044151) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tickets", force: :cascade do |t|
    t.decimal "cost", null: false
    t.integer "penalty_type", null: false
    t.datetime "issue_date", null: false
    t.datetime "due_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_id"
    t.index ["vehicle_id"], name: "index_tickets_on_vehicle_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "firebase_id"
    t.string "name", null: false
    t.string "phone_number", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["firebase_id"], name: "unique_firebase_id", unique: true
  end

  create_table "users_vehicles", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "vehicle_id", null: false
    t.index ["user_id", "vehicle_id"], name: "index_users_vehicles_on_user_id_and_vehicle_id"
    t.index ["user_id"], name: "index_users_vehicles_on_user_id"
    t.index ["vehicle_id", "user_id"], name: "index_users_vehicles_on_vehicle_id_and_user_id"
    t.index ["vehicle_id"], name: "index_users_vehicles_on_vehicle_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "licence_plate", null: false
    t.string "make", null: false
    t.string "model", null: false
    t.integer "year", null: false
    t.index ["licence_plate"], name: "index_vehicles_on_licence_plate", unique: true
  end

  add_foreign_key "tickets", "vehicles"
  add_foreign_key "users_vehicles", "users"
  add_foreign_key "users_vehicles", "vehicles"
end
