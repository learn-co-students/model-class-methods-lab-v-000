class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    boats = Boat.select("boats.*").includes(:classifications).where(classifications: {name: "Catamaran"})
    boats.map do |boat|
      boat.captain
    end
  end

  def self.sailors
    Captain.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq

    #Captain.joins(:boats).includes(:classifications).where(classifications: {name: "Catamaran"})
  end

  def self.motorboats
    Captain.includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.non_sailors
    Captain.all - self.sailors
  end

  def self.talented_seafarers
    self.motorboats & self.sailors
  end

    #Captain.joins(:boats).includes(:classifications).where(classifications: {name: "Catamaran"})
end
  #def self.sailboats
    #boats = Boat.arel_table
    #Boat.select("boats.*").includes(:classifications).where(classifications: {name: "Sailboat"})
  #end

#  def self.with_three_classifications
  #  Boat.joins(:classifications).group("boat_id").having("COUNT(*) = 3")
#  end
