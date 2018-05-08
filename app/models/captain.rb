class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #byebug
    #return all captains whose boats are classified as catamarans
    #you need the classifications for each boat :boat_classifications table
    #you need the classification name :classifications table
    #you need to limit the list by classification name : 'Catamaran'
    #you need to return a list of captains

    #the boat has a list of it's classifications
    #a captiains boats, each knows about it's classifications
    #joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")

    includes(:classifications).where(classifications: { name: 'Catamaran' })

  end
end
