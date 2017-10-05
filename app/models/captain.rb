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
    select (<<-SQL
    SELECT captains.name, GROUP_CONCAT(classifications.name) AS classifications_names from captains
    INNER JOIN boats
      ON boats.captain_id = captains.id
    INNER JOIN boat_classifications
      ON boats.id = boat_classifications.id
    INNER JOIN classifications
      ON boat_classifications.classification_id = classifications.id
    GROUP BY (captains.id)
      HAVING classifications_names LIKE '%Motorboat%'
      AND classifications_names LIKE '%Sailboat%'
    SQL
    )
  end

  def self.non_sailors
    joins(:boats, :boat_classifications, :classifications).where.not('classifications.name = ?', 'Sailboat').distinct
  end

end
