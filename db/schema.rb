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

ActiveRecord::Schema.define(version: 2021_06_13_174046) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exchange_logs", id: false, force: :cascade do |t|
    t.datetime "updated"
    t.float "usd_rate", default: 0.0
    t.float "gbp_rate", default: 0.0
    t.float "eur_rate", default: 0.0
    t.index ["updated"], name: "index_exchange_logs_on_updated", unique: true, order: :desc
  end

  create_table "saved_averages", force: :cascade do |t|
    t.integer "kind"
    t.string "key"
    t.float "usd_sum", default: 0.0
    t.integer "usd_count", default: 0
    t.float "gbp_sum", default: 0.0
    t.integer "gbp_count", default: 0
    t.float "eur_sum", default: 0.0
    t.integer "eur_count", default: 0
    t.index ["kind", "key"], name: "index_saved_averages_on_kind_and_key", unique: true
  end

end
