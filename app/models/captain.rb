class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where(classifications: {name: "Catamaran"}).uniq
  end

  def self.sailors
    joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboats
    joins(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end


  def self.talented_seamen
    Captain.where('captain_id IN (?) AND (?)', Captain.sailors, Captain.motorboats)

    #Captain.joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq & Captain.joins(boats: :classifications).where(classifications:  {name: "Motorboat"}).uniq
    #Captain.joins(boats: :classifications).where(classifications: {name: "Sailboat", name: "Motorboat"}).uniq

  end
end

Captain.where('captain_id IN (?) AND (?)', Captain.sailors, Captain.motorboats)


