class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #byebug
    #Boat.catamarans
    #returns all captains of catamarans
      all.collect do |captain|
        captain.boats.collect do |boat|
          boat.classifications.collect do |classification|
            classification.name == "Catamaran"
          end
        end
      end
    end
    #return all captains whose boats are classified as catamarans
    #you need the classifications for each boat :boat_classifications table
    #you need the classification name :classifications table
    #you need to limit the list by classification name : 'Catamaran'
    #you need to return a list of captains

    #the boat has a list of it's classifications
    #a captiains boats, each knows about it's classifications
    #joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")




  end
end
