class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})

  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq


  end

  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq


  end



  def self.talented_seamen
    #a = includes(boats: :classifications).where(classifications: {name: "Sailboat"})
    #b = includes(boats: :classifications).where(classifications: {name: "Motorboat"})

    self.all.where(id: sailors & motorboaters)

  end

  def self.non_sailors
    #includes(boats: :classifications).where("classifcations.name != Sailboat").references(:classifications).uniq
    self.all.where(id: self.all - sailors)
  end
end
