ActiveRecord::Schema.define(version: 20140313192430) do

  create_table "boat_classifications", force: :cascade do |t|
    t.integer  "boat_id"
    t.integer  "classification_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "boats", force: :cascade do |t|
    t.string   "name"
    t.integer  "length"
    t.integer  "captain_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "captains", force: :cascade do |t|
    t.string   "name"
    t.boolean  "admiral"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "classifications", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
