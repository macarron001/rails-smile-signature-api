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

ActiveRecord::Schema[7.0].define(version: 2022_07_01_124104) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.date "schedule_date", null: false
    t.string "mobile"
    t.string "branch"
    t.time "schedule_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "full_name", null: false
    t.string "email", null: false
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "dental_records", force: :cascade do |t|
    t.json "services"
    t.json "tooth"
    t.string "branch"
    t.string "remarks"
    t.bigint "patient_record_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name", null: false
    t.index ["patient_record_id"], name: "index_dental_records_on_patient_record_id"
    t.index ["user_id"], name: "index_dental_records_on_user_id"
  end

  create_table "patient_records", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gender"
    t.string "date_of_birth"
    t.string "mobile"
    t.string "email"
    t.json "obligation"
    t.string "full_name", null: false
    t.string "address", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.date "date_of_birth"
    t.string "gender"
    t.string "mobile"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "middle_name"
    t.string "position"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.json "services"
    t.string "status"
    t.string "branch", null: false
    t.decimal "amount", precision: 8, scale: 2
    t.decimal "remaining", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "payment_type"
    t.bigint "patient_record_id"
    t.bigint "user_id", null: false
    t.string "full_name", null: false
    t.index ["patient_record_id"], name: "index_transactions_on_patient_record_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.string "role"
    t.string "email", null: false
    t.string "gender"
    t.boolean "has_profile", default: false
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "appointments", "users"
  add_foreign_key "dental_records", "patient_records"
  add_foreign_key "dental_records", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "transactions", "patient_records"
  add_foreign_key "transactions", "users"
end
