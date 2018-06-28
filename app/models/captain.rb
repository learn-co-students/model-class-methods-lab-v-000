class Captain < ActiveRecord::Base
  has_many :boats

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motors
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
end

def self.talented_seafarers
  # I really don't understand how this works - need to review and figure out how to arrive a this
  where("id IN (?)", self.sailors.pluck(:id) & self.motors.pluck(:id))
  # self.sailors & self.motors
  # self.sailors || self.motors
  # includes(boats: :classifications).where(clzssifications: {name: ["Sailboat", "Motorbooat"]}).uniq
  # includes(boats: :classifications).where(classifications: {name: ["Sailboat" && "Motorbooat"]})
  # {name: "Sailboat"} && {name: "Motorboat"}
end

def self.non_sailors
  # includes(boats: :classifications).where.not(classifications: {name: "Sailboat"}).uniq
 # Don't understand this one either
  where.not("id IN (?)", self.sailors.pluck(:id))
end

end
