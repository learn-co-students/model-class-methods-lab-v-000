class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators
    joins(:boats, :boat_classifications, :classifications).where('classifications.name = ?', 'Catamaran').distinct
  end

  def self.sailors
    joins(:boats, :boat_classifications, :classifications).where('classifications.name = ?', 'Sailboat').distinct
  end

  def self.talented_seamen
    sailors = joins(:boats, :boat_classifications, :classifications).where('classifications.name = ?', 'Sailboat').distinct
    motorers = joins(:boats, :boat_classifications, :classifications).where('classifications.name = ?', 'Motorboat').distinct
    intersection = sailors & motorers
    intersection.map {|i| i.name }
  end

  # def self.talented_seamen
  #   select (<<-SQL
  #   SELECT captains.name, GROUP_CONCAT(classifications.name) AS classifications_names from captains
  #   INNER JOIN boats
  #     ON boats.captain_id = captains.id
  #   INNER JOIN boat_classifications
  #     ON boats.id = boat_classifications.id
  #   INNER JOIN classifications
  #     ON boat_classifications.classification_id = classifications.id
  #   GROUP BY (captains.id)
  #     HAVING classifications_names LIKE '%Motorboat%'
  #     AND classifications_names LIKE '%Sailboat%'
  #   SQL
  #   )
  # end

  # def self.talented_seamen
  #   boats = Boat.arel_table
  #   captains = Captain.arel_table
  #   unwanted_classifications = ["Ketch", "Sloop", "Center Console", "Catamaran", "Bass Boat", "Pontoon Boat", "Cat Rig Boat", "Trawler", "RIB"]
  #   unwanted_captain_ids = Captain.joins(:boats).select(captains[:id]).where(boats[:classifications].in(unwanted_classifications))
  #   target_captain_ids = captains.project(captains[:id]).except(unwanted_classifications)
  #   Captain.where(captains[:id].in(target_captain_ids))
  # end

  def self.non_sailors
    sailors = joins(:boats, :boat_classifications, :classifications).where('classifications.name = ?', 'Sailboat').distinct.pluck(:name)
    all.pluck(:name) - sailors
  end

end
