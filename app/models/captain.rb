class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    where(id: Boat.catamaran_boats.map{|boat|boat.captain_id})
  end

  def self.motorboat_operators
    where(id: Boat.motorboat_boats.map{|boat|boat.captain_id})
  end

  def self.sailors
    where(id: Boat.sailboats.map{|boat|boat.captain_id})
  end

  def self.talented_seamen
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
