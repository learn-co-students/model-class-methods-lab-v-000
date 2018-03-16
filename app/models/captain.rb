class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboats
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).distinct
  end

  def self.talented_seamen
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboats.pluck(:id))
  end

  # this is basically firing up a sequel that asks to return captain objects
  # where their ids match the returned ids from self.sailors and self.motorboats
  #and since the test itself has a .pluck(:name), the test results are
  #returning an array of names of the captains

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
