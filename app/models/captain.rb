class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    binding.pry
    #find all captains of boats where classification is catamaran
    self.joins(:boats).joins(:classifications).where(boats: {classifications: {name: "Catamaran"}})
    Boat.joins(:classifications).where(classifications: {name: "Catamaran"})
    Boat.joins(:classifications).where(classifications: {name: "Catamaran"}).joins(:captains).where(captains: name)


    self.joins(:boats).group('captain.id').having('')
    Boat.joins(:classifications).group('boats.id').having('count(boat_id) == 3')

  end
end
