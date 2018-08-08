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

ActiveRecord::Schema.define(version: 20180612105222) do

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

  create_table "employee_experiences", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "organization_id"
    t.boolean "block_created"
    t.string "status", limit: 30
    t.date "start_date"
    t.date "end_date"
    t.boolean "is_currently_employed"
    t.string "designation", limit: 50
    t.string "request_reason"
    t.date "confirmed_date"
    t.string "confirmed_person_name", limit: 50
    t.string "confirmation_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employee_experiences_on_employee_id"
    t.index ["organization_id"], name: "index_employee_experiences_on_organization_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name", limit: 50
    t.string "email", limit: 50
    t.string "phone_number", limit: 20
    t.string "address"
    t.date "career_start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "block_created", default: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", limit: 50
    t.string "registration_id", limit: 50
    t.string "email", limit: 50
    t.string "phone_number", limit: 20
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "block_created", default: false
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id"
    t.string "request_type"
    t.string "identifier"
    t.text "request"
    t.text "response"
    t.text "blockchain_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role_id"
    t.integer "profile_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["profile_id"], name: "index_users_on_profile_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

end
