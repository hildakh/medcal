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

ActiveRecord::Schema[8.0].define(version: 2025_02_20_063804) do
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
    t.decimal "unit_price"
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

  add_foreign_key "medication_dosages", "dosages"
  add_foreign_key "medication_dosages", "medications"
end
