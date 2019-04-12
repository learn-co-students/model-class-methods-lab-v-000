class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all
  end

  def self.longest
    Boat.find((Boat.longest_boat)[0].id).classifications
    #boat = Boat.find(num)
    #boat.classifications
    #Classification.joins(:boats).group('boats.length').having(boats: Boat.longest_boat)
    #Boat.longest_boat.classification_name

  end



end
#Boat.joins(:classifications).group("boat_id").having("COUNT(*) = 3")
#Captain.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
#Agent.where(licence_to_kill: true).maximum(:number_of_gadgets)
# Agent.joins(:mission).group('missions.name').average(:number_of_gadgets) 2
## => { "Moonraker"=> 4.4, "Octopussy"=> 4.9 }
#Mission.joins(:agents).where( agents: { name: 'James Bond' })
#Agent.joins(:mission).group('missions.name').average(:number_of_gadgets)
