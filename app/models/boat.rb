class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    limit(5)

    # SELECT boats.* FROM boats LIMIT 5
  end

  def self.dinghy
    where('length < ?', 20)

    # SELECT boats.* FROM boats WHERE (length < 20)
  end

  def self.ship
    where('length >= ?', 20)

    # SELECT boats.* FROM boats WHERE (length >= 20)
  end

  def self.last_three_alphabetically
    order(name: :desc).limit(3)

    # SELECT boats.* FROM boats ORDER BY boats.name DESC LIMIT 3
  end

  def self.without_a_captain
    where(captain_id: nil)

    # SELECT boats.* FROM boats WHERE boats.captain_id IS NULL
  end

  def self.sailboats
    ## Two ways to do the same job...
    ## Option 1
    # includes(:classifications).where(:classifications => {:name => 'Sailboat'})

    ## Option 2
    Classification.find_by(name: 'Sailboat').boats

    # SELECT classifications.* FROM classifications WHERE classifications.name = ? LIMIT 1 [["name", "Sailboat"]]
  end

  def self.with_three_classifications
    joins(:classifications).select('boats.id').group('boats.id').having('count(classifications.id) = 3')

    # SELECT boats.id FROM boats
    #   INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id
    #   INNER JOIN classifications ON classifications.id = boat_classifications.classification_id
    #   GROUP BY boats.id
    #   HAVING count(classifications.id) = 3
  end

end
