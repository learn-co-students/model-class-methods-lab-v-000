class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    catamaran = Classification.find_by(name: 'Catamaran')
    #binding.pry
    cat_caps = catamaran.boats.map {|b| b.captain }

    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seamen
    #where("id IN (?)").where(self.motorboaters.pluck(:id) & self.sailors.pluck(:id))
    #includes(boats: :classifications).where(classifications: {name: ["Sailboat", "Motorboat"]})
    #includes(boats: :classifications).where(classifications: {name: "Motorboat"})
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
