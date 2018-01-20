class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end 

  def self.talented_seamen
    where("id IN (?)", self.sailors.collect {|sailor| sailor.id} & self.motorboaters.collect {|motor_man| motor_man.id})
  end 

  def self.non_sailors
    where.not("id IN (?)", self.sailors.collect {|non_sailor| non_sailor.id})
  end
end
