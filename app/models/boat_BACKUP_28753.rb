class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
<<<<<<< HEAD

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    all.where("length < '20'")
  end

  def self.ship
    all.where("length > '20'")
  end

  def self.last_three_alphabetically
     all.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    all.where("captain_id is null")
  end

  def self.sailboats
    Boat.joins(:classifications).where('classifications.name = ?', 'Sailboat')
  end

  def self.with_three_classifications
    # Solution #1:

    # arr = Boat.all.select { |boat| boat.classifications.count == 3}
    # Boat.where(id: arr.map(&:id))

    # Solution #2:

    query = <<-SQL
    SELECT boats.* FROM boats
    JOIN boat_classifications ON boat_classifications.boat_id = boats.id
    JOIN classifications ON classifications.id = boat_classifications.classification_id
    GROUP BY boats.id
    HAVING COUNT(*) = 3
    SQL
    arr = self.find_by_sql(query)
    Boat.where(id: arr.map(&:id))
    #
    # # Solution #3
    #
    # Boat.joins(:classifications).group("boats.id").select("boats.*").having("count(*) = 3")
  end
=======
>>>>>>> 4971cb53f290a9e7272e339aeb997b5c1f31444a
end
