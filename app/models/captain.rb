class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: :classifications).where(classifications: {name: "Catamaran"}).group(:captain_id)
  end

  def self.motorboat_operators
    self.joins(boats: :classifications).where(classifications: {name: "Motorboat"}).group(:captain_id)
  end

  def self.sailors
    self.joins(boats: :classifications).where(classifications: {name: "Sailboat"}).group(:captain_id)
  end

  def self.talented_seamen
    self.where("id IN (?) AND id IN (?)", self.sailors.pluck(:id), self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    self.where("id NOT IN (?)", self.sailors.pluck(:id))
  end

end

# create_table "captains", force: :cascade do |t|
#   t.string   "name"
#   t.boolean  "admiral"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end