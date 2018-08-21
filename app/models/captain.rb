class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # binding.pry
    #find all captains of boats where classification is catamaran
    #User.joins("LEFT JOIN bookmarks ON bookmarks.bookmarkable_type = 'Post' AND bookmarks.user_id = users.id")
    boats = Boat.joins(:classifications).where(classifications: {name: "Catamaran"})
    captain_ids = boats.map(&:captain_id)
    binding.pry

      self.select { |m| m.id == captain_ids.any? }
    }

    where(_id: {})
    #
    # self.joins(:boats).joins(:classifications).where(boats: {classifications: {name: "Catamaran"}})
    #
    # Boat.joins(:captains).where(captains: "captain_id")
    # Captain.joins(:boats).where(boats: "captain_id")
    # self.joins(:boats).group('captain.id').having('')
    # Boat.joins(:classifications).group('boats.id').having('count(boat_id) == 3')

  end
end
