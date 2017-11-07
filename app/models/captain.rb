class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  ## MY PURE AR PASS
    # where("classifications.name = ?", "Catamaran").joins("INNER JOIN boats
    # ON captains.id = boats.captain_id
    # INNER JOIN boat_classifications
    # ON boats.id = boat_classifications.boat_id
    # INNER JOIN classifications
    # ON boat_classifications.classification_id = classifications.id").group("captains.id").select("name")
  ## MY PURE SQL
    # SELECT captains.name FROM captains
    # INNER JOIN boats
    # ON captains.id = boats.captain_id
    # INNER JOIN boat_classifications
    # ON boats.id = boat_classifications.boat_id
    # INNER JOIN classifications
    # ON boat_classifications.classification_id = classifications.id
    # WHERE classifications.name = "Catamaran"
    # GROUP BY captains.id

  ## AR CLEAN PASS
    includes(boats: :classifications).where(classifications: { name: "Catamaran" }).uniq
  ## TA PURE AR
    # SELECT DISTINCT captains.name
    # FROM captains
    # INNER JOIN boats
    # ON boats.captain_id = captains.id
    # INNER JOIN boat_classifications
    # ON boat_classifications.boat_id = boats.id
    # INNER JOIN classifications
    # ON classifications.id = boat_classifications.classification_id
    # WHERE classifications.name = 'Catamaran'


  end

  def self.sailors
    ## MY PURE SQL
      # SELECT captains.name FROM captains
      # INNER JOIN boats
      # ON captains.id = boats.captain_id
      # INNER JOIN boat_classifications
      # ON boats.id = boat_classifications.boat_id
      # INNER JOIN classifications
      # ON boat_classifications.classification_id = classifications.id
      # WHERE classifications.name = "Sailboat"
      # GROUP BY captains.id

    ## MY PURE AR PASS
      # where("classifications.name = ?", "Sailboat").joins("INNER JOIN boats
      # ON captains.id = boats.captain_id
      # INNER JOIN boat_classifications
      # ON boats.id = boat_classifications.boat_id
      # INNER JOIN classifications
      # ON boat_classifications.classification_id = classifications.id").group("captains.id").select("captains.name")

    ## TA PURE AR
      # SELECT DISTINCT captains.name
      # FROM captains
      # INNER JOIN boats
      # ON boats.captain_id = captains.id
      # INNER JOIN boat_classifications
      # ON boat_classifications.boat_id = boats.id
      # INNER JOIN classifications
      # ON classifications.id = boat_classifications.classification_id
      # WHERE classifications.name = 'Sailboat'

    ## AR CLEAN PASS
      includes(boats: :classifications).where(classifications: { name: "Sailboat" }).uniq
  end

  # SOLN Helper Method
  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seamen
    # SELECT captains.name FROM captains
    # INNER JOIN boats
    # ON captains.id = boats.captain_id
    # INNER JOIN boat_classifications
    # ON boats.id = boat_classifications.boat_id
    # INNER JOIN classifications
    # ON boat_classifications.classification_id = classifications.id
    # WHERE classifications.name = "Motorboat"  OR classifications.name = "Sailboat"
    # GROUP BY classifications.id

    # where("classifications.name = ? OR classifications.name = ?", "Motorboat", "Sailboat").joins("INNER JOIN boats
    # ON captains.id = boats.captain_id
    # INNER JOIN boat_classifications
    # ON boats.id = boat_classifications.boat_id
    # INNER JOIN classifications
    # ON boat_classifications.classification_id = classifications.id").group("classifications.id").select("captains.name")

    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
  #   SELECT captains.name FROM captains
	#   INNER JOIN boats
  # 	ON captains.id = boats.captain_id
	#   INNER JOIN boat_classifications
	#   ON boats.id = boat_classifications.boat_id
	#   INNER JOIN classifications
	#   ON boat_classifications.classification_id = classifications.id
	#   WHERE captains.id NOT IN (
	# 	  SELECT captains.id FROM captains
	# 	  INNER JOIN boats
	# 	  ON captains.id = boats.captain_id
	# 	  WHERE boats.id IN (
	# 	    SELECT boats.id FROM boats
	# 	    INNER JOIN boat_classifications
	# 	    ON boats.id = boat_classifications.boat_id
	# 	    INNER JOIN classifications
	# 	    ON boat_classifications.classification_id = classifications.id
	# 	    WHERE classifications.name = "Sailboat"
	# 	  )
	#  )
	#  GROUP BY captains.name
  where.not("id IN (?)", self.sailors.pluck(:id))

  end






end
