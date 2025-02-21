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

ActiveRecord::Schema[8.0].define(version: 2025_02_20_090146) do
  create_table "dosages", force: :cascade do |t|
    t.string "amount"
    t.string "frequency"
    t.integer "default_duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medication_dosages", force: :cascade do |t|
    t.integer "medication_id", null: false
    t.integer "dosage_id", null: false
    t.decimal "unit_price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dosage_id"], name: "index_medication_dosages_on_dosage_id"
    t.index ["medication_id"], name: "index_medication_dosages_on_medication_id"
  end

  create_table "medications", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prescription_items", force: :cascade do |t|
    t.integer "prescription_id", null: false
    t.integer "medication_dosage_id", null: false
    t.integer "custom_duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medication_dosage_id"], name: "index_prescription_items_on_medication_dosage_id"
    t.index ["prescription_id"], name: "index_prescription_items_on_prescription_id"
  end

  create_table "prescriptions", force: :cascade do |t|
    t.decimal "budget", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "medication_dosages", "dosages"
  add_foreign_key "medication_dosages", "medications"
  add_foreign_key "prescription_items", "medication_dosages"
  add_foreign_key "prescription_items", "prescriptions"
end
