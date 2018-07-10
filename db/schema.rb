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

ActiveRecord::Schema.define(version: 2018_07_10_014325) do

  create_table "musicians", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "provider"
    t.string "uid"
    t.string "image_url"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.string "name"
    t.integer "midi_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "frequency"
    t.string "solfege"
    t.boolean "reference", default: false
  end

  create_table "practises", force: :cascade do |t|
    t.integer "musician_id"
    t.integer "scale_id"
    t.integer "experience", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scales", force: :cascade do |t|
    t.string "name"
    t.string "scale_type", default: "Unknown"
    t.string "origin", default: "Unknown"
    t.string "pattern"
    t.string "melody_rules", default: "No special rules"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.boolean "private", default: true
  end

end
