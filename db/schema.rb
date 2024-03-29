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

ActiveRecord::Schema[7.0].define(version: 2024_03_03_204118) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "map_markers", force: :cascade do |t|
    t.decimal "latitude", precision: 10, scale: 6, null: false
    t.decimal "longitude", precision: 10, scale: 6, null: false
    t.string "icon_type", default: "0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "payments", force: :cascade do |t|
    t.string "payment_intent_id", null: false
    t.bigint "ticket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_payments_on_ticket_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.decimal "cost", null: false
    t.string "penalty_type", null: false
    t.datetime "issue_date", null: false
    t.datetime "due_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_id"
    t.string "status", default: "pending", null: false
    t.string "ticket_number", null: false
    t.string "dispute_reason"
    t.index ["vehicle_id"], name: "index_tickets_on_vehicle_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "firebase_id"
    t.string "name", null: false
    t.string "phone_number"
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "drivers_licence_number"
    t.string "push_token"
    t.index ["firebase_id"], name: "unique_firebase_id", unique: true
  end

  create_table "users_vehicles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "vehicle_id", null: false
    t.index ["user_id"], name: "index_users_vehicles_on_user_id"
    t.index ["vehicle_id", "user_id"], name: "index_users_vehicles_on_vehicle_id_and_user_id", unique: true
    t.index ["vehicle_id"], name: "index_users_vehicles_on_vehicle_id"
  end

  create_table "vehicle_invitations", force: :cascade do |t|
    t.string "code", null: false
    t.bigint "vehicle_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_valid", default: true, null: false
    t.index ["vehicle_id"], name: "index_vehicle_invitations_on_vehicle_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "licence_plate", null: false
    t.string "make", null: false
    t.string "model", null: false
    t.integer "year", null: false
    t.string "province", null: false
    t.index ["licence_plate", "province"], name: "index_vehicles_on_licence_plate_and_province", unique: true
  end

  add_foreign_key "payments", "tickets"
  add_foreign_key "tickets", "vehicles"
  add_foreign_key "users_vehicles", "users"
  add_foreign_key "users_vehicles", "vehicles"
  add_foreign_key "vehicle_invitations", "vehicles"
end
