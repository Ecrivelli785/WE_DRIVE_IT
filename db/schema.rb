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

ActiveRecord::Schema.define(version: 2019_11_07_224023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.string "brand"
    t.string "model"
    t.string "transmission"
    t.string "poliza"
    t.string "green_card"
    t.string "fuel_type"
    t.string "plate"
    t.integer "year"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.index ["user_id"], name: "index_cars_on_user_id"
  end

  create_table "choices", force: :cascade do |t|
    t.string "declaration"
    t.boolean "correct"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "driver_requirements", force: :cascade do |t|
    t.boolean "quiz_certification"
    t.string "license"
    t.string "record_police"
    t.integer "bank_account"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_driver_requirements_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "ride_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ride_id"], name: "index_payments_on_ride_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "statement"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string "content"
    t.integer "rating"
    t.bigint "ride_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ride_id"], name: "index_reviews_on_ride_id"
  end

  create_table "rides", force: :cascade do |t|
    t.string "status"
    t.string "origin"
    t.string "destination"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "user_id"
    t.integer "estimated_price"
    t.datetime "actual_start_time"
    t.datetime "actual_end_time"
    t.bigint "driver_id"
    t.bigint "service_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.integer "total_price_cents", default: 0, null: false
    t.integer "total_time_ride"
    t.string "destination_principal"
    t.string "start_day"
    t.string "end_day"
    t.index ["service_type_id"], name: "index_rides_on_service_type_id"
    t.index ["user_id"], name: "index_rides_on_user_id"
  end

  create_table "service_types", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name"
    t.string "city"
    t.string "address"
    t.string "dni"
    t.string "role"
    t.string "photo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cars", "users"
  add_foreign_key "choices", "questions"
  add_foreign_key "driver_requirements", "users"
  add_foreign_key "payments", "rides"
  add_foreign_key "reviews", "rides"
  add_foreign_key "rides", "service_types"
  add_foreign_key "rides", "users"
end
