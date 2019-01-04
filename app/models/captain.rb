class Captain < ActiveRecord::Base
  has_many :boats
  has_many    :boat_classifications, through: :boats
  has_many    :classifications, through: :boat_classifications

  def self.catamaran_operators
    joins(:boats, :boat_classifications, :classifications).where(classifications: {name: "Catamaran"}).uniq
  end

  def self.sailors
    joins(:boats, :boat_classifications, :classifications).where(classifications: {name: "Sailboat"}).uniq  
  end

  def self.talented_seafarers
    joins(:boats, :boat_classifications, :classifications).where(classifications: {name: "Motorboat"}).uniq & joins(:boats, :boat_classifications, :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.non_sailors
    # binding.pry
    # non_sailors = []
    # self.all.each do |capn|
    #   capn.classifications.each do |cls|
    #     non_sailors << capn if capn.classifications.include?("Sailboat")
    #   end
    # end
    Captain.all - joins(:boats, :boat_classifications, :classifications).where(classifications: {name: "Sailboat"}).uniq
    # Classification.where.not(name: "Sailboat")
  end
end

# create_t create_table "boat_classifications", force: :cascade do |t|
#     t.integer  "boat_id"
#     t.integer  "classification_id"
#     t.datetime "created_at",        null: false
#     t.datetime "updated_at",        null: false
#   end

#   create_table "boats", force: :cascade do |t|
#     t.string   "name"
#     t.integer  "length"
#     t.integer  "captain_id"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#   end

#   create_table "captains", force: :cascade do |t|
#     t.string   "name"
#     t.boolean  "admiral"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#   end

#   create_table "classifications", force: :cascade do |t|
#     t.string   "name"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#   end