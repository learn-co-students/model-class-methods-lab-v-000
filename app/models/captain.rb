class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: [{boat_classifications: :classification}]).where('classifications.name = ?', 'Catamaran')

    # SELECT captains.* FROM captains
    #   INNER JOIN boats ON boats.captain_id = captains.id
    #   INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id
    #   INNER JOIN classifications ON classifications.id = boat_classifications.classification_id
    #   WHERE (classifications.name = 'Catamaran')
  end

  def self.sailors
    joins(boats: [{boat_classifications: :classification}]).where('classifications.name = ?', 'Sailboat').distinct

    # SELECT DISTINCT captains.* FROM captains
    #   INNER JOIN boats ON boats.captain_id = captains.id
    #   INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id
    #   INNER JOIN classifications ON classifications.id = boat_classifications.classification_id
    #   WHERE (classifications.name = 'Sailboat')
  end

  def self.talented_seamen
    
  end
end
