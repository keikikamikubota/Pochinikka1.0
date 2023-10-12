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

ActiveRecord::Schema[7.0].define(version: 2023_10_12_024946) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "import_details", force: :cascade do |t|
    t.integer "sheet_column_number"
    t.integer "selected_title"
    t.bigint "sheet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sheet_id"], name: "index_import_details_on_sheet_id"
  end

  create_table "sheets", force: :cascade do |t|
    t.string "title", null: false
    t.integer "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "phone", null: false
    t.text "note"
    t.text "admin_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "option1"
    t.string "option2"
    t.string "option3"
    t.string "option4"
    t.string "option5"
    t.string "option6"
    t.string "option7"
    t.string "option8"
    t.string "option9"
    t.string "option10"
    t.integer "sheet_code"
    t.bigint "status_id", default: 1, null: false
    t.index ["status_id"], name: "index_users_on_status_id"
  end

  add_foreign_key "import_details", "sheets"
  add_foreign_key "users", "statuses"
end
