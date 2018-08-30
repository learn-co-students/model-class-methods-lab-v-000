class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications:{name:"Sailboat"}).distinct
  end

  def self.motorboats
    includes(boats: :classifications).where(classifications:{name:"Motorboat"}).distinct
  end

  def self.talented_seafarers
    #combines the 2 arrays and returns whats common between them
    where("name IN (?)", self.sailors.pluck(:name) & self.motorboats.pluck(:name))
  end

  def self.non_sailors
    where('name NOT IN (?)', self.sailors.pluck(:name))
  end

end
