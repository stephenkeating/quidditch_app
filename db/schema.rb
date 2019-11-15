# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_15_030018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer "user_house_id"
    t.integer "computer_house_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "houses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "founder"
    t.string "animal"
    t.string "head_professor"
    t.string "ghost"
  end

  create_table "turns", force: :cascade do |t|
    t.integer "game_id"
    t.integer "user_energy"
    t.integer "computer_energy"
    t.integer "user_score"
    t.integer "computer_score"
    t.integer "user_bludger_outcome"
    t.integer "computer_bludger_outcome"
    t.integer "user_snitch_chance"
    t.integer "computer_snitch_chance"
    t.integer "user_quaffle_allocation"
    t.integer "user_bludger_allocation"
    t.integer "user_snitch_allocation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.integer "house_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "answer_one"
    t.string "answer_two"
    t.string "answer_three"
    t.string "answer_four"
    t.string "answer_five"
  end

end
