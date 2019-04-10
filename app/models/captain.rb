class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    boats = Boat.select("boats.*").includes(:classifications).where(classifications: {name: "Catamaran"})
    boats.map do |boat|
      boat.captain
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

end
