class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    limit(5)
  end
  
  def self.dinghy
    where("length < ?", 20)
  end
  
  def self.ship
    where("length >= ?", 20)
  end
  
  def self.last_three_alphabetically
    order("name DESC").limit(3)
  end
  
  def self.without_a_captain
    where(captain_id: nil)
  end
  
  def self.sailboats
    includes(:classifications).where(classifications: {name: 'Sailboat'})
  end
  
  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  end
end

=begin
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
=end